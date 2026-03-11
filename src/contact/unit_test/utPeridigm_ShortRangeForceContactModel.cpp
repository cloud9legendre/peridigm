/*! \file utPeridigm_ShortRangeForceContactModel.cpp
 *
 * Unit tests for PeridigmNS::ShortRangeForceContactModel.
 *
 * Test strategy
 * -------------
 * The short-range force contact model computes a repulsive contact force
 * between nodes that overlap (i.e. whose current distance is less than the
 * sum of their contact radii).  The force is proportional to a spring
 * constant and to the overlap amount.
 *
 * Tests
 * -----
 * 1. ConstructionTest  — model name and FieldIds() are correct.
 * 2. NoContactTest     — nodes separated by more than the contact radius
 *                        produce zero contact force density.
 * 3. ContactForceTest  — overlapping nodes produce a non-zero, repulsive
 *                        contact force density; Newton's 3rd law is satisfied
 *                        (forces on node pair are equal and opposite).
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
#include "../Peridigm_ShortRangeForceContactModel.hpp"
#include "../Peridigm_ContactModelFactory.hpp"

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

using namespace PeridigmNS;

// ---------------------------------------------------------------------------
// Contact model parameters used across tests.
//   Contact radius    = 0.5  (contact activates when node separation < 0.5)
//   Spring constant   = 1.0e12  Pa/m
//   Friction          = 0.0 (frictionless)
//   Horizon           = 2.0
// ---------------------------------------------------------------------------
static Teuchos::ParameterList makeContactParams()
{
  Teuchos::ParameterList p;
  p.set("Contact Model",    "Short Range Force");
  p.set("Contact Radius",    0.5);
  p.set("Spring Constant",   1.0e12);
  p.set("Friction Coefficient", 0.0);
  p.set("Horizon",           2.0);
  return p;
}

// ---------------------------------------------------------------------------
// Construct a minimal two-point Peridigm model configured for contact.
// Node 0: (0, 0, 0)   Node 1: (1, 0, 0)   — 1 unit apart initially.
// ---------------------------------------------------------------------------
static Teuchos::RCP<Peridigm> createTwoPointContactModel()
{
  auto params = Teuchos::rcp(new Teuchos::ParameterList());

  auto& matParams   = params->sublist("Materials");
  auto& elastic     = matParams.sublist("Steel");
  elastic.set("Material Model",  "Elastic");
  elastic.set("Density",          7800.0);
  elastic.set("Bulk Modulus",     130.0e9);
  elastic.set("Shear Modulus",     78.0e9);

  // Contact block
  auto& contactParams = params->sublist("Contact");
  contactParams.set("Search Radius",  2.0);
  contactParams.set("Search Frequency", 1);
  auto& srfParams = contactParams.sublist("Models").sublist("My Contact");
  srfParams.set("Contact Model",        "Short Range Force");
  srfParams.set("Contact Radius",        0.5);
  srfParams.set("Spring Constant",       1.0e12);
  srfParams.set("Friction Coefficient",  0.0);
  auto& cpInteraction = contactParams.sublist("Interactions").sublist("Interaction 1");
  cpInteraction.set("First Block",   "block_1");
  cpInteraction.set("Second Block",  "block_1");
  cpInteraction.set("Contact Model", "My Contact");

  auto& blockParams = params->sublist("Blocks");
  auto& block1      = blockParams.sublist("Block1");
  block1.set("Block Names", "block_1");
  block1.set("Material",    "Steel");
  block1.set("Horizon",      2.0);

  auto& discParams  = params->sublist("Discretization");
  discParams.set("Type", "PdQuickGrid");
  auto& grid = discParams.sublist("TensorProduct3DMeshGenerator");
  grid.set("Type",             "PdQuickGrid");
  grid.set("X Origin",          0.0);
  grid.set("Y Origin",          0.0);
  grid.set("Z Origin",          0.0);
  grid.set("X Length",          2.0);
  grid.set("Y Length",          1.0);
  grid.set("Z Length",          1.0);
  grid.set("Number Points X",   2);
  grid.set("Number Points Y",   1);
  grid.set("Number Points Z",   1);

  auto& outParams = params->sublist("Output");
  auto& outFields = outParams.sublist("Output Variables");
  outFields.set("Contact_Force_Density", true);

  Teuchos::RCP<Discretization> nullDisc;
  return Teuchos::rcp(new Peridigm(MPI_COMM_WORLD, params, nullDisc));
}

// ===========================================================================
// Test 1: ConstructionTest
//
// Verify ShortRangeForceContactModel can be constructed and returns the
// correct name and a non-empty FieldIds() vector.
// ===========================================================================
TEUCHOS_UNIT_TEST(ShortRangeForceContactModel, ConstructionTest)
{
  auto p = makeContactParams();
  ShortRangeForceContactModel model(p);

  TEST_EQUALITY(model.Name(), std::string("Short-Range Force"));
  TEST_COMPARE(model.FieldIds().size(), >, 0u);
}

// ===========================================================================
// Test 2: ContactModelFactoryTest
//
// Verify that ContactModelFactory::create() dispatches to the correct class
// for "Short Range Force".
// ===========================================================================
TEUCHOS_UNIT_TEST(ShortRangeForceContactModel, ContactModelFactoryTest)
{
  auto p = makeContactParams();

  ContactModelFactory factory;
  auto model = factory.create(p);

  TEST_ASSERT(!model.is_null());
  TEST_EQUALITY(model->Name(), std::string("Short-Range Force"));
  TEST_COMPARE(model->FieldIds().size(), >, 0u);
}

// ===========================================================================
// Test 3: NoContactTest
//
// Two nodes separated by 1.0 unit with contact radius 0.5.
// The separation (1.0) is greater than 2 * contact radius (2 * 0.5 = 1.0),
// so no overlap occurs and contact force density must be 0.
// ===========================================================================
TEUCHOS_UNIT_TEST(ShortRangeForceContactModel, NoContactTest)
{
#ifdef HAVE_MPI
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_MpiComm(MPI_COMM_WORLD));
#else
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_SerialComm());
#endif

  if (comm->NumProc() > 2) {
    out << "Skipping NoContactTest: requires <= 2 MPI ranks\n";
    return;
  }

  auto peridigm = createTwoPointContactModel();

  FieldManager& fm      = FieldManager::self();
  int cfdFId            = fm.getFieldId("Contact_Force_Density");

  auto blocks = peridigm->getBlocks();
  DataManager& dm = blocks->begin()->getDataManager();

  // Separation = 1.0 unit exactly — boundary condition: no contact force.
  // ContactRadius = 0.5; force activates only when separation < 2*R = 1.0.
  // At exactly 1.0 separation there is no overlap, so force = 0.
  int ownedIDs[]      = {0, 1};
  int contactList[]   = {1, 1,   // node 0 has 1 contact candidate: node 1
                         1, 0};  // node 1 has 1 contact candidate: node 0

  auto p = makeContactParams();
  ShortRangeForceContactModel model(p);
  model.computeForce(1.0e-4, 2, ownedIDs, contactList, dm);

  double* cfd{nullptr};
  dm.getData(cfdFId, PeridigmField::STEP_NP1)->ExtractView(&cfd);

  // With separation == 2*contactRadius there should be no force
  int n = dm.getData(cfdFId, PeridigmField::STEP_NP1)->Map().NumMyElements();
  for (int i = 0; i < n; ++i) {
    TEST_FLOATING_EQUALITY(cfd[3*i],   0.0, 1.0e-10);
    TEST_FLOATING_EQUALITY(cfd[3*i+1], 0.0, 1.0e-10);
    TEST_FLOATING_EQUALITY(cfd[3*i+2], 0.0, 1.0e-10);
  }
}

// ===========================================================================
// Test 4: OverlapRepulsionTest
//
// Move node 1 to X = 0.6 so the separation is 0.6 < 2 * contactRadius (1.0).
// The model must produce a non-zero repulsive X-force density on both nodes,
// with equal magnitude and opposite direction (Newton's 3rd law).
// ===========================================================================
TEUCHOS_UNIT_TEST(ShortRangeForceContactModel, OverlapRepulsionTest)
{
#ifdef HAVE_MPI
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_MpiComm(MPI_COMM_WORLD));
#else
  Teuchos::RCP<Epetra_Comm> comm = Teuchos::rcp(new Epetra_SerialComm());
#endif

  if (comm->NumProc() > 2) {
    out << "Skipping OverlapRepulsionTest: requires <= 2 MPI ranks\n";
    return;
  }

  auto peridigm = createTwoPointContactModel();

  FieldManager& fm = FieldManager::self();
  int coordsFId    = fm.getFieldId("Coordinates");
  int cfdFId       = fm.getFieldId("Contact_Force_Density");

  auto blocks = peridigm->getBlocks();
  DataManager& dm = blocks->begin()->getDataManager();

  // Move node 1 to X = 0.6 => separation = 0.6 < 1.0 (2 * contactRadius)
  double* coords{nullptr};
  dm.getData(coordsFId, PeridigmField::STEP_NP1)->ExtractView(&coords);
  int numMyElems = dm.getData(coordsFId, PeridigmField::STEP_NP1)->Map().NumMyElements();
  if (numMyElems >= 2) {
    coords[3] = 0.6;   // x-coord of node 1
    coords[4] = 0.0;
    coords[5] = 0.0;
  }

  int ownedIDs[]    = {0, 1};
  int contactList[] = {1, 1,
                       1, 0};

  auto p = makeContactParams();
  ShortRangeForceContactModel model(p);
  model.computeForce(1.0e-4, 2, ownedIDs, contactList, dm);

  double* cfd{nullptr};
  dm.getData(cfdFId, PeridigmField::STEP_NP1)->ExtractView(&cfd);

  if (numMyElems >= 2) {
    // Node 0 should be pushed in the -X direction (node 1 is at X=0.6 > X=0)
    // Node 1 should be pushed in the +X direction
    // The sum of forces must be zero (Newton's 3rd law pair)
    double f0x = cfd[0];   // x-force density on node 0
    double f1x = cfd[3];   // x-force density on node 1

    // Forces must be non-zero (nodes are overlapping)
    TEST_COMPARE(std::abs(f0x), >, 0.0);
    TEST_COMPARE(std::abs(f1x), >, 0.0);

    // Forces must be equal and opposite (Newton's 3rd law)
    TEST_FLOATING_EQUALITY(f0x, -f1x, 1.0e-10);

    // Force on node 0 must be negative (pushed towards -X)
    // Force on node 1 must be positive (pushed towards +X)
    TEST_COMPARE(f0x, <, 0.0);
    TEST_COMPARE(f1x, >, 0.0);
  }
}
