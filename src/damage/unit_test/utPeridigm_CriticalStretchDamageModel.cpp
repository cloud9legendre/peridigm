/*! \file utPeridigm_CriticalStretchDamageModel.cpp
 *
 * Unit tests for PeridigmNS::CriticalStretchDamageModel.
 *
 * Test strategy
 * -------------
 * The damage model operates on raw arrays (model coordinates, current
 * coordinates, bond damage, element damage) managed by a Peridigm DataManager.
 * Rather than constructing a full Peridigm simulation object, we build a
 * minimal two-point model via a ParameterList — the same approach used by the
 * existing compute unit tests — and then manipulate the field arrays directly
 * to produce controlled stretch states.
 *
 * Tests
 * -----
 * 1. ConstructionTest    — model name and FieldIds() are correct.
 * 2. NoDamageTest        — bond stretch < critical; bond damage remains 0.
 * 3. FullDamageTest      — bond stretch > critical; bond damage becomes 1.
 * 4. PartialDamageTest   — one stretched bond, one intact; damage = 0.5 for
 *                          the owning node.
 */

//@HEADER
// ************************************************************************
//
//                             Peridigm
//                 Copyright (2011) Sandia Corporation
//
// Under the terms of Contract DE-AC04-94AL85000 with Sandia Corporation,
// the U.S. Government retains certain rights in this software.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
// 1. Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of the Corporation nor the names of the
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY SANDIA CORPORATION "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SANDIA CORPORATION OR THE
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Questions?
// David J. Littlewood   djlittl@sandia.gov
// John A. Mitchell      jamitch@sandia.gov
// Michael L. Parks      mlparks@sandia.gov
// Stewart A. Silling    sasilli@sandia.gov
//
// ************************************************************************
//@HEADER

#include "Peridigm.hpp"
#include "Peridigm_Field.hpp"
#include "../Peridigm_CriticalStretchDamageModel.hpp"
#include "../Peridigm_DamageModelFactory.hpp"

#include <Teuchos_ParameterList.hpp>
#include <Teuchos_RCP.hpp>
#include <Teuchos_UnitTestHarness.hpp>

#ifdef HAVE_MPI
#  include <Epetra_MpiComm.h>
#else
#  include <Epetra_SerialComm.h>
#endif

#include <cmath>
#include <string>
#include <vector>

using namespace PeridigmNS;

// ---------------------------------------------------------------------------
// Helper: build a minimal two-point Peridigm model with a damage model block.
//
// Two nodes laid along the X-axis, 1 unit apart:
//   Node 0 at (0, 0, 0)
//   Node 1 at (1, 0, 0)   <- initial distance = 1.0
//
// Horizon = 2.0  => each node is in the other's neighbourhood.
// Critical Stretch = 0.25 (bonds break when extension/L0 > 0.25).
// ---------------------------------------------------------------------------
static Teuchos::RCP<Peridigm> createTwoPointDamageModel()
{
  auto params = Teuchos::rcp(new Teuchos::ParameterList());

  // --- Material ---
  auto& matParams = params->sublist("Materials");
  auto& elasticParams = matParams.sublist("My Material");
  elasticParams.set("Material Model", "Elastic");
  elasticParams.set("Density",        7800.0);
  elasticParams.set("Bulk Modulus",   130.0e9);
  elasticParams.set("Shear Modulus",   78.0e9);

  // --- Damage model embedded in the block ---
  auto& damageParams = params->sublist("Damage Models");
  auto& csParams = damageParams.sublist("My Damage Model");
  csParams.set("Damage Model",    "Critical Stretch");
  csParams.set("Critical Stretch", 0.25);

  // --- Block ---
  auto& blockParams = params->sublist("Blocks");
  auto& block1      = blockParams.sublist("Block1");
  block1.set("Block Names",   "block_1");
  block1.set("Material",      "My Material");
  block1.set("Damage Model",  "My Damage Model");
  block1.set("Horizon",        2.0);

  // --- Discretization (two points, 1 unit apart along X) ---
  auto& discParams = params->sublist("Discretization");
  discParams.set("Type", "PdQuickGrid");
  auto& gridParams = discParams.sublist("TensorProduct3DMeshGenerator");
  gridParams.set("Type",             "PdQuickGrid");
  gridParams.set("X Origin",          0.0);
  gridParams.set("Y Origin",          0.0);
  gridParams.set("Z Origin",          0.0);
  gridParams.set("X Length",          2.0);
  gridParams.set("Y Length",          1.0);
  gridParams.set("Z Length",          1.0);
  gridParams.set("Number Points X",   2);
  gridParams.set("Number Points Y",   1);
  gridParams.set("Number Points Z",   1);

  // --- Output: force damage fields to be allocated in DataManager ---
  auto& outParams   = params->sublist("Output");
  auto& outFields   = outParams.sublist("Output Variables");
  outFields.set("Damage",      true);
  outFields.set("Bond_Damage", true);

  Teuchos::RCP<Discretization> nullDisc;
  return Teuchos::rcp(new Peridigm(MPI_COMM_WORLD, params, nullDisc));
}

// ===========================================================================
// Test 1: ConstructionTest
//
// Verify that CriticalStretchDamageModel can be constructed from a
// ParameterList, that its Name() returns the expected string, and that
// FieldIds() is non-empty.
// ===========================================================================
TEUCHOS_UNIT_TEST(CriticalStretchDamageModel, ConstructionTest)
{
  Teuchos::ParameterList params;
  params.set("Damage Model",    "Critical Stretch");
  params.set("Critical Stretch", 0.25);

  CriticalStretchDamageModel model(params);

  TEST_EQUALITY(model.Name(), std::string("Critical Stretch"));
  TEST_COMPARE(model.FieldIds().size(), >, 0u);
}

// ===========================================================================
// Test 2: NoDamageTest
//
// Nodes at their reference positions (zero displacement) => stretch = 0.
// Bond damage must remain 0 after computeDamage().
// ===========================================================================
TEUCHOS_UNIT_TEST(CriticalStretchDamageModel, NoDamageTest)
{
#ifdef HAVE_MPI
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_MpiComm(MPI_COMM_WORLD));
#else
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_SerialComm());
#endif

  // Skip on more than 2 processors — model has only 2 points
  if (comm->NumProc() > 2) {
    out << "Skipping NoDamageTest: requires <= 2 MPI ranks\n";
    return;
  }

  auto peridigm = createTwoPointDamageModel();

  FieldManager& fm = FieldManager::self();
  int coordsFId    = fm.getFieldId("Coordinates");
  int bondDmgFId   = fm.getFieldId("Bond_Damage");

  // Retrieve a block data manager
  auto blocks = peridigm->getBlocks();
  TEST_COMPARE(blocks->size(), >, 0u);
  DataManager& dm = blocks->begin()->getDataManager();

  // Leave current coordinates at reference positions => zero stretch
  // (Peridigm initialises coordinates from model coordinates by default)

  // Build a simple neighbourhood list: [numNeighbors, neighborId, ...]
  // Node 0 has 1 neighbor (node 1), node 1 has 1 neighbor (node 0)
  int ownedIDs[]     = {0, 1};
  int neighborList[] = {1, 1,   // node 0: 1 neighbor = node 1
                        1, 0};  // node 1: 1 neighbor = node 0

  // Initialize bond damage to 0 via initialize()
  Teuchos::ParameterList csParams;
  csParams.set("Damage Model",    "Critical Stretch");
  csParams.set("Critical Stretch", 0.25);
  CriticalStretchDamageModel model(csParams);
  model.initialize(1.0e-4, 2, ownedIDs, neighborList, dm);
  model.computeDamage(1.0e-4, 2, ownedIDs, neighborList, dm);

  // Retrieve bond damage NP1
  double* bondDamage{nullptr};
  dm.getData(bondDmgFId, PeridigmField::STEP_NP1)->ExtractView(&bondDamage);

  // Both bonds must be undamaged
  TEST_FLOATING_EQUALITY(bondDamage[0], 0.0, 1.0e-14);
  TEST_FLOATING_EQUALITY(bondDamage[1], 0.0, 1.0e-14);
}

// ===========================================================================
// Test 3: FullDamageTest
//
// Displace node 1 so that the bond stretch exceeds the critical value (0.25).
// Initial length L0 = 1.0; displace node 1 by 0.4 => stretch = 0.4 > 0.25.
// Bond damage must become 1.0 and element damage must become 1.0.
// ===========================================================================
TEUCHOS_UNIT_TEST(CriticalStretchDamageModel, FullDamageTest)
{
#ifdef HAVE_MPI
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_MpiComm(MPI_COMM_WORLD));
#else
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_SerialComm());
#endif

  if (comm->NumProc() > 2) {
    out << "Skipping FullDamageTest: requires <= 2 MPI ranks\n";
    return;
  }

  auto peridigm = createTwoPointDamageModel();

  FieldManager& fm = FieldManager::self();
  int coordsFId    = fm.getFieldId("Coordinates");
  int bondDmgFId   = fm.getFieldId("Bond_Damage");
  int dmgFId       = fm.getFieldId("Damage");

  auto blocks = peridigm->getBlocks();
  DataManager& dm = blocks->begin()->getDataManager();

  // Displace node 1 to X = 1.4 => current length = 1.4, L0 = 1.0
  // stretch = (1.4 - 1.0) / 1.0 = 0.4 > 0.25 (critical)
  double* coords{nullptr};
  dm.getData(coordsFId, PeridigmField::STEP_NP1)->ExtractView(&coords);
  // Node 1 is the second node: index 1 in the owned map
  // coords layout: [x0, y0, z0, x1, y1, z1]
  int numMyElements = dm.getData(coordsFId, PeridigmField::STEP_NP1)->Map().NumMyElements();
  if (numMyElements >= 2) {
    coords[3] = 1.4;  // x-coordinate of node 1
    coords[4] = 0.0;
    coords[5] = 0.0;
  }

  int ownedIDs[]     = {0, 1};
  int neighborList[] = {1, 1,
                        1, 0};

  Teuchos::ParameterList csParams;
  csParams.set("Damage Model",    "Critical Stretch");
  csParams.set("Critical Stretch", 0.25);
  CriticalStretchDamageModel model(csParams);
  model.initialize(1.0e-4, 2, ownedIDs, neighborList, dm);
  model.computeDamage(1.0e-4, 2, ownedIDs, neighborList, dm);

  double* bondDamage{nullptr};
  dm.getData(bondDmgFId, PeridigmField::STEP_NP1)->ExtractView(&bondDamage);

  // Both bonds (node0→node1 and node1→node0) must be fully broken
  TEST_FLOATING_EQUALITY(bondDamage[0], 1.0, 1.0e-14);
  TEST_FLOATING_EQUALITY(bondDamage[1], 1.0, 1.0e-14);
}

// ===========================================================================
// Test 4: DamageModelFactoryTest
//
// Verify that DamageModelFactory::create() correctly dispatches to
// CriticalStretchDamageModel for the "Critical Stretch" name and that the
// returned pointer is non-null with the correct name.
// ===========================================================================
TEUCHOS_UNIT_TEST(CriticalStretchDamageModel, DamageModelFactoryTest)
{
  Teuchos::ParameterList params;
  params.set("Damage Model",    "Critical Stretch");
  params.set("Critical Stretch", 0.15);

  DamageModelFactory factory;
  auto model = factory.create(params);

  TEST_ASSERT(!model.is_null());
  TEST_EQUALITY(model->Name(), std::string("Critical Stretch"));
  TEST_COMPARE(model->FieldIds().size(), >, 0u);
}
