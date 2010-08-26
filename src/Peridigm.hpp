/*! \file Peridigm.hpp */

// ***********************************************************************
//
//                             Peridigm
//                 Copyright (2009) Sandia Corporation
//
// Under the terms of Contract DE-AC04-94AL85000 with Sandia Corporation,
// the U.S. Government retains certain rights in this software.
//
// This library is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2.1 of the
// License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
// 
// Questions? 
// David J. Littlewood   djlittl@sandia.gov 
// John A. Mitchell      jamitch@sandia.gov
// Michael L. Parks      mlparks@sandia.gov
// Stewart A. Silling    sasilli@sandia.gov
//
// ***********************************************************************

#ifndef PERIDIGM_HPP
#define PERIDIGM_HPP

#include <Epetra_MpiComm.h>
#include <Epetra_SerialComm.h>
#include <Teuchos_FancyOStream.hpp>
#include <Teuchos_ParameterList.hpp>
#include <Teuchos_RCP.hpp>

#include "Peridigm_AbstractDiscretization.hpp"
#include "materials/Peridigm_Material.hpp"

namespace PeridigmNS {

  class Peridigm {

  public:

    //! Constructor
    Peridigm(const Teuchos::RCP<const Epetra_Comm>& comm,
             const Teuchos::RCP<Teuchos::ParameterList>& params);

    //! Initialize discretization and maps
    void initializeDiscretization();

    //! Initialize contact
    void initializeContact();

    //! Initialize material objects
    void initializeMaterials();

    //! Destructor
    ~Peridigm(){};

  private:

    //! Parameterlist of entire input deck
    Teuchos::RCP<Teuchos::ParameterList> peridigmParams;

    //! Epetra communicator established by Peridigm_Factory
    Teuchos::RCP<const Epetra_Comm> peridigmComm;

    //! Output stream
    Teuchos::RCP<Teuchos::FancyOStream> out;

    //! Maps for scalar and R3 vector data
    Teuchos::RCP<const Epetra_BlockMap> oneDimensionalMap;
    Teuchos::RCP<const Epetra_BlockMap> oneDimensionalOverlapMap;
    Teuchos::RCP<const Epetra_BlockMap> threeDimensionalMap;
    Teuchos::RCP<const Epetra_BlockMap> threeDimensionalOverlapMap;

    //! Data structures for bonds
    double* bondData;
    Teuchos::RCP<const Epetra_BlockMap> bondMap;

    //! Contact flag
    bool computeContact;

    //! Contact search radius
    double contactSearchRadius;

    //! Contact search frequency
    int contactSearchFrequency;

    //! Material models
    //! \todo Use Teuchos::ArrayRCP to store materials?
    std::vector< Teuchos::RCP<PeridigmNS::Material> > materials;



  };
}

#endif // PERIDIGM_HPP