/*! \file Peridigm_OutputManager_VTK_XML.hpp */
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
#ifndef PERIDIGM_OUTPUTMANAGER_EXODUSII_HPP
#define PERIDIGM_OUTPUTMANAGER_EXODUSII_HPP

#include <Peridigm_OutputManager.hpp>

#include <Teuchos_ParameterList.hpp>


// Forward declaration
namespace PeridigmNS {
  class Peridigm; 
} 

namespace PeridigmNS {
  
  class OutputManager_ExodusII: public PeridigmNS::OutputManager {
    
  public:
    
    //! Basic constructor.
    OutputManager_ExodusII(const Teuchos::RCP<Teuchos::ParameterList>& params, 
                          PeridigmNS::Peridigm *peridigm_,
                          Teuchos::RCP< std::vector<PeridigmNS::Block> > blocks);
    
    //! Destructor.
    virtual ~OutputManager_ExodusII();

    //! Write data to disk
    virtual void write(Teuchos::RCP< std::vector<PeridigmNS::Block> > blocks, double);

  private:
    
    //! Copy constructor.
    OutputManager_ExodusII( const OutputManager& OM );
    
    //! Assignment operator.
    OutputManager_ExodusII& operator=( const OutputManager& OM );

    //! Valid Teuchos::ParameterList 
    Teuchos::ParameterList getValidParameterList();

    //! Container for data array of processor ID number for each node on my proc
    Teuchos::RCP< std::vector<int> > proc_num;

    //! Parent pointer
    PeridigmNS::Peridigm *peridigm;

    //! Exodus file handle
    int file_handle;

    //! Integer timestep index for exodus timestamp. Differs from "count" var in parent class.
    int exodus_count;

  };
  
}
 
#endif //PERIDIGM_OUTPUTMANAGER_EXODUSII_HPP