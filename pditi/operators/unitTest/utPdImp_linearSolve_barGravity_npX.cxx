/*
 * utPimp_linearSolve_barGravity_np4.cxx
 *
 *  Created on: Jun 9, 2010
 *      Author: jamitch
 */

#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_ALTERNATIVE_INIT_API
#include <boost/test/unit_test.hpp>
#include <boost/test/parameterized_test.hpp>
#include "../PdImpMpiFixture.h"
#include "PdNeighborhood.h"
#include "PdQuickGrid.h"
#include "PdQuickGridParallel.h"
#include "PdNeighborhood.h"
#include "PdZoltan.h"
#include "Field.h"
#include "../PdImpMaterials.h"
#include "../PdImpOperator.h"
#include "../PdImpOperatorUtilities.h"
#include "../DirichletBcSpec.h"
#include "../BodyLoadSpec.h"
#include "../StageFunction.h"
#include "../Loader.h"
#include "../StageComponentDirichletBc.h"
#include "../ComponentDirichletBcSpec.h"
#include "../IsotropicElasticConstitutiveModel.h"
#include "../ConstitutiveModel.h"
#include "PdVTK.h"
#include <set>
#include <Epetra_FEVbrMatrix.h>
#include <Epetra_SerialSymDenseMatrix.h>
#include <Epetra_LinearProblem.h>
#include <AztecOO.h>
#include <utility>
#include <map>
#include <vector>
#include <cstdlib>
#include <time.h>


using namespace PdQuickGrid;
using namespace PdNeighborhood;
using namespace Field_NS;
using PdImp::IsotropicElasticConstitutiveModel;
using PdImp::ConstitutiveModel;
using std::tr1::shared_ptr;
using namespace boost::unit_test;

static int numProcs;
static int myRank;

const int nx = 5;
const int ny = nx;
const double lX = 1.0;
const double lY = lX;
const double lZ = 10.0;
const double xStart  = -lX/2.0/nx;
const double xLength =  lX;
const double yStart  = -lY/2.0/ny;
const double yLength =  lY;
const int nz = (int)(lZ * nx / lX);
const double zStart  = -lZ/2.0/nz;
const double zLength =  lZ;
const double zMAX = zStart + zLength - zLength / 2.0 / nz;
const PdQPointSet1d xSpec(nx,xStart,xLength);
const PdQPointSet1d ySpec(ny,yStart,yLength);
const PdQPointSet1d zSpec(nz,zStart,zLength);
const int numCells = nx*ny*nz;
const double horizon=1.5*sqrt(pow(lX/nx,2)+pow(lY/ny,2)+pow(lZ/nz,2));
const PdImp::BulkModulus _K(130000.0);
const PdImp::PoissonsRatio _MU(0.0);
const PdImp::IsotropicHookeSpec isotropicSpec(_K,_MU);
const double g = 9.807e-3;
const double rho = 7800e-6;
const int vectorNDF=3;

using PdVTK::writeField;
using PdImp::DirichletBcSpec;
using PdImp::ComponentDirichletBcSpec;
using PdImp::StageFunction;
using PdImp::StageComponentDirichletBc;

shared_ptr<PdImp::PdImpOperator> getPimpOperator(PdGridData& decomp,Epetra_MpiComm& comm);
shared_ptr<Epetra_CrsGraph> getGraph(shared_ptr<RowStiffnessOperator>& jacobian);
shared_ptr<Epetra_RowMatrix>
getOperator
(
		const vector<shared_ptr<StageComponentDirichletBc> >& bcArray,
		shared_ptr<Epetra_CrsGraph>& graphPtr,
		shared_ptr<RowStiffnessOperator>& jacobian
);

void linearSolve_barGravity() {
	Epetra_MpiComm comm = Epetra_MpiComm(MPI_COMM_WORLD);
	PdQuickGrid::TensorProduct3DMeshGenerator cellPerProcIter(numProcs,horizon,xSpec,ySpec,zSpec,PdQuickGrid::SphericalNorm);
	PdGridData decomp =  PdQuickGrid::getDiscretization(myRank, cellPerProcIter);
	decomp = getLoadBalancedDiscretization(decomp);

	/*
	 * Create Pimp Operator
	 */
	shared_ptr<PdImp::PdImpOperator> op = getPimpOperator(decomp,comm);
	shared_ptr<ConstitutiveModel> fIntOperator(new IsotropicElasticConstitutiveModel(isotropicSpec));
	op->addConstitutiveModel(fIntOperator);



	/*
	 * Get points for bc's
	 */
	PdNeighborhood::CoordinateLabel axis = PdNeighborhood::Z;
	Pd_shared_ptr_Array<int> bcIdsFixed = PdNeighborhood::getPointsInNeighborhoodOfAxisAlignedMaximumValue(axis,decomp.myX,decomp.numPoints,horizon,zMAX);
	std::sort(bcIdsFixed.get(),bcIdsFixed.get()+bcIdsFixed.getSize());

	/**
	 * Create boundary conditions spec
	 */
	vector<shared_ptr<StageComponentDirichletBc> > bcs(1);
	ComponentDirichletBcSpec fixedSpec = ComponentDirichletBcSpec::getAllComponents(bcIdsFixed);
	StageFunction constStageFunction(0.0,0.0);
	shared_ptr<StageComponentDirichletBc> bcFixed(new StageComponentDirichletBc(fixedSpec,constStageFunction));
	bcs[0] = bcFixed;

	/*
	 * Create Jacobian -- note that SCOPE of jacobian is associated with the PimpOperator "op"
	 */
	Field<double> uOwnedField(DISPL3D,decomp.numPoints);
	uOwnedField.setValue(0.0);
	std::tr1::shared_ptr<RowStiffnessOperator> jacobian = op->getRowStiffnessOperator(uOwnedField,horizon);

	/*
	 * Create graph
	 */
	shared_ptr<Epetra_CrsGraph> graphPtr = getGraph(jacobian);

	/*
	 * Create Epetra_RowMatrix
	 */

	shared_ptr<Epetra_RowMatrix> mPtr = getOperator(bcs,graphPtr,jacobian);

	/*
	 * Create force field for body load
	 */
	FieldSpec::FieldSpec fNSpec(FieldSpec::FORCE,FieldSpec::VECTOR3D,"fN");
	Field_NS::Field<double> fN(fNSpec,decomp.numPoints);

	/*
	 * Create body load
	 */
	Pd_shared_ptr_Array<int> localIds(decomp.numPoints);
	{
		/*
		 * Create list of local ids
		 */
		int *ids=localIds.get();
		const int *end=localIds.end();
		for(int i=0;ids!=end;i++,ids++)
			*ids = i;
	}
	double u[] = {0,0,1};
	double uMag = g*rho;
	PdImp::BodyLoadSpec bodyLoadSpec(u,localIds);
	StageFunction bodyLoadFunction(0,uMag);
	shared_ptr<PdImp::Loader> bodyLoad = bodyLoadSpec.getStageLoader(bodyLoadFunction);
	bodyLoad->computeOwnedExternalForce(1.0,fN);

	/*
	 * Apply boundary conditions to body load
	 */
	double *f = fN.getArray().get();
	bcFixed->applyHomogeneousForm(fN);

	Epetra_LinearProblem linProblem;
	linProblem.SetOperator(mPtr.get());
	linProblem.AssertSymmetric();

	const Epetra_BlockMap& rangeMap  = mPtr->OperatorRangeMap();
	const Epetra_BlockMap& domainMap  = mPtr->OperatorDomainMap();

	Epetra_Vector rhs(View,rangeMap,f);
	Epetra_Vector lhs(View,domainMap,uOwnedField.getArray().get());

	linProblem.SetRHS(&rhs);
	linProblem.SetLHS(&lhs);
	BOOST_CHECK(0==linProblem.CheckInput());

	AztecOO solver(linProblem);
	solver.SetAztecOption(AZ_precond, AZ_Jacobi);
	BOOST_CHECK(0==solver.CheckInput());
	solver.Iterate(500,1e-6);
	/*
	 * Write problem set up parameters to file
	 */
	vtkSmartPointer<vtkUnstructuredGrid> grid = PdVTK::getGrid(decomp.myX,decomp.numPoints);
	PdVTK::writeField(grid,uOwnedField);
	PdVTK::writeField(grid,fN);
	vtkSmartPointer<vtkXMLPUnstructuredGridWriter> writer = PdVTK::getWriter("linearSolve_barGravity.pvtu", comm.NumProc(), comm.MyPID());
	PdVTK::write(writer,grid);

}


shared_ptr<PdImp::PdImpOperator> getPimpOperator(PdGridData& decomp,Epetra_MpiComm& comm) {
	PdImp::PdImpOperator *op = new PdImp::PdImpOperator(comm,decomp);
	return shared_ptr<PdImp::PdImpOperator>(op);
}

shared_ptr<Epetra_CrsGraph> getGraph(shared_ptr<RowStiffnessOperator>& jacobian){
	const Epetra_BlockMap& rowMap   = jacobian->getRowMap();
	const Epetra_BlockMap& colMap = jacobian->getColMap();

	/*
	 * Epetra Graph
	 */
	Pd_shared_ptr_Array<int> numCols = jacobian->getNumColumnsPerRow();
	Epetra_CrsGraph *graph = new Epetra_CrsGraph(Copy,rowMap,colMap,numCols.get());
	for(int row=0;row<rowMap.NumMyElements();row++){
		Pd_shared_ptr_Array<int> rowLIDs = jacobian->getColumnLIDs(row);
		std::size_t numCol = rowLIDs.getSize();
		int *cols = rowLIDs.get();
		BOOST_CHECK(0==graph->InsertMyIndices(row,numCol,cols));
	}
	BOOST_CHECK(0==graph->FillComplete());
	return shared_ptr<Epetra_CrsGraph>(graph);
}

shared_ptr<Epetra_RowMatrix>
getOperator
(
		const vector<shared_ptr<StageComponentDirichletBc> >& bcArray,
		shared_ptr<Epetra_CrsGraph>& graphPtr,
		shared_ptr<RowStiffnessOperator>& jacobian
)
{
	std::cout << "Begin jacobian calculation\n";
	const Epetra_BlockMap& rowMap   = jacobian->getRowMap();

	/*
	 * Loop over Bc's and create set of ids that can be searched
	 */

	vector<std::set<int> > bcPointIds(bcArray.size());
	{
		vector<shared_ptr<StageComponentDirichletBc> >::const_iterator bcIter = bcArray.begin();
		for(int i=0;bcIter != bcArray.end(); i++,bcIter++){
			StageComponentDirichletBc* stageComponentPtr = bcIter->get();
			const DirichletBcSpec& spec = stageComponentPtr->getSpec();
			const Pd_shared_ptr_Array<int>& ids = spec.getPointIds();
			bcPointIds[i]= std::set<int>(ids.get(),ids.get()+ids.getSize());
		}
	}

	/*
	 * Create a searchable set for bc
	 */

	/*
	 * Epetra Matrix
	 * PERHAPS the 'operator' can keep its own copy of Graph, then this
	 * can be a 'View'
	 */

	Epetra_FEVbrMatrix *m = new Epetra_FEVbrMatrix(Copy,*(graphPtr.get()));

	Epetra_SerialDenseMatrix k;
	k.Shape(vectorNDF,vectorNDF);
	for(int row=0;row<rowMap.NumMyElements();row++){
		Pd_shared_ptr_Array<int> rowLIDs = jacobian->getColumnLIDs(row);
		std::size_t numCol = rowLIDs.getSize();
		int *cols = rowLIDs.get();
		BOOST_CHECK(0==m->BeginReplaceMyValues(row,numCol,cols));

		/*
		 * loop over columns in row and submit block entry
		 */
		Pd_shared_ptr_Array<double> actualK = jacobian->computeRowStiffness(row, rowLIDs);


		/*
		 * 1) Zero out row as necessary due to BC's
		 * 2) Assemble into matrix -- zero columns as necessary
		 * 3)
		 */
		vector<std::set<int> >::iterator pointSetIter = bcPointIds.begin();
		vector<shared_ptr<StageComponentDirichletBc> >::const_iterator bcIter = bcArray.begin();
		for(;bcIter != bcArray.end(); bcIter++, pointSetIter++){
			const std::set<int>::const_iterator bcIdsEnd = pointSetIter->end();

			/*
			 * Get components to be applied
			 */
			StageComponentDirichletBc* stageComponentPtr = bcIter->get();
			const DirichletBcSpec& spec = stageComponentPtr->getSpec();
			vector<DirichletBcSpec::ComponentLabel> components = spec.getComponents();

			/*
			 * Search for row in bcIds
			 */
			// if this is true, then this row is a bc row
			if(bcIdsEnd != pointSetIter->find(row)) {

				/*
				 * 1) This row has a bc; need to zero out in stiffness
				 * 2) Watch for diagonal: place "1" on the diagonal
				 */

				/*
				 * Create array of pointers to each row/component that BC is applied
				 */
				vector<double*> rowPtrs(components.size(), NULL);
				vector<double*> diagPtrs(components.size(), NULL);
				for(std::size_t r=0;r<components.size();r++)
					rowPtrs[r]= actualK.get()+components[r];

				for(int* colPtr=cols; colPtr!=cols+numCol;colPtr++){
					int col = *colPtr;

					for(std::size_t r=0;r<components.size();r++){
						/*
						 * 0) Save diagonal location
						 * 1) Set row element to zero
						 * 2) Move to next column
						 * 3) Note that there are 3 columns in 3x3 matrix
						 */

						/*
						 * Save location of diagonal for this component
						 */
						diagPtrs[r] = rowPtrs[r] + 3 * components[r];

						/*
						 * Zero out row corresponding with component
						 * Increment row pointer to next column
						 */
						*(rowPtrs[r])=0; rowPtrs[r]+=3;
						*(rowPtrs[r])=0; rowPtrs[r]+=3;
						*(rowPtrs[r])=0; rowPtrs[r]+=3;

					}
					/*
					 * If this is true, then we are on the diagonal
					 * Need to put "1" on the strict diagonal by component
					 */
					if(row==col) {
						for(std::size_t r=0;r<components.size();r++){
							*(diagPtrs[r]) = 1.0;
						}

					}

				}

			} else {
				/*
				 * This is not a bc row but we still have to check for columns that may have a bc assigned to them
				 * In this case, we just have to zero the column
				 */
				double *kPtr=actualK.get();
				for(int* colPtr=cols; colPtr!=cols+numCol;colPtr++,kPtr+=9){
					int col = *colPtr;
					if(bcIdsEnd == pointSetIter->find(col)) continue;
					/*
					 * We have a column that must be zero'd
					 */
					/*
					 * Zero out column for each component that is applied
					 */
					double *colPtr=0;
					for(std::size_t r=0;r<components.size();r++){
						colPtr = kPtr+3*components[r];
						for(int r=0;r<3;r++)
							colPtr[r]=0;
					}

				}

			}

		}

		/*
		 * Now just populate the matrix
		 */
		double *kPtr = actualK.get();
		for(int* colPtr=cols; colPtr!=cols+numCol;colPtr++){

			/*
			 * Fill 'k'
			 */
			for(int c=0;c<3;c++){
				double *colK = k[c];
				for(int r=0;r<3;r++,kPtr++)
					colK[r] = - *kPtr;
			}

			BOOST_CHECK(0==m->SubmitBlockEntry(k));
		}


		/*
		 * Finalize this row
		 */
		BOOST_CHECK(0==m->EndSubmitEntries());
	}

	BOOST_CHECK(0==m->FillComplete());

	std::cout << "END jacobian calculation\n";
	return shared_ptr<Epetra_RowMatrix>(m);
}


bool init_unit_test_suite()
{
	// Add a suite for each processor in the test
	bool success=true;

	test_suite* proc = BOOST_TEST_SUITE( "linearSolve_barGravity" );
	proc->add(BOOST_TEST_CASE( &linearSolve_barGravity ));
	framework::master_test_suite().add( proc );
	return success;

}

bool init_unit_test()
{
	init_unit_test_suite();
	return true;
}

int main
(
		int argc,
		char* argv[]
)
{
	// Initialize MPI and timer
	PdImpRunTime::PimpMpiFixture pimpMPI = PdImpRunTime::PimpMpiFixture::getPimpMPI(argc,argv);
	const Epetra_Comm& comm = pimpMPI.getEpetra_Comm();

	// These are static (file scope) variables
	myRank = comm.MyPID();
	numProcs = comm.NumProc();

	// Initialize UTF
	return unit_test_main( init_unit_test, argc, argv );
}