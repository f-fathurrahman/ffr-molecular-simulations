/* [[pr_02_1 - all pairs, two dimensions]] */

#define NDIM  2

#include "in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;

Mol *mol;
VecR region, vSum;
VecI initUcell;
real deltaT, density, rCut, temperature, timeNow, uSum, velMag, vvSum;
Prop kinEnergy, totEnergy;
int moreCycles, nMol, stepAvg, stepCount, stepEquil, stepLimit;
real virSum;
Prop pressure;

NameList nameList[] = {
  NameR(deltaT),
  NameR(density),
  NameI(initUcell),
  NameI(stepAvg),
  NameI(stepEquil),
  NameI(stepLimit),
  NameR(temperature),
};

#include "SetupJob.c"
#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"

#include "LeapfrogStep.c"
#include "ComputeForces.c"
#include "ApplyBoundaryCond.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "SingleStep.c"

#include "PrintSummary.c"

int main (int argc, char **argv)
{
  GetNameList(argc, argv);

  PrintNameList(stdout);
  
  SetParams();
  
  SetupJob();
  
  // MD steps
  moreCycles = 1;
  while( moreCycles ) {
    SingleStep();
    if( stepCount >= stepLimit ) moreCycles = 0;
  }
}

#include "in_rand.c"
#include "in_errexit.c"
#include "in_namelist.c"
