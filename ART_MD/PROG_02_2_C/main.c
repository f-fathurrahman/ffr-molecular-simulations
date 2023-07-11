
/* [[pr_02_2 - velocity distribution]] */

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
int moreCycles, nMol, randSeed, stepAvg, stepCount, stepEquil, stepLimit;
VecI cells;
int *cellList;
real dispHi, rNebrShell;
int *nebrTab, nebrNow, nebrTabFac, nebrTabLen, nebrTabMax;
real *histVel, hFunction, rangeVel;
int countVel, limitVel, sizeHistVel, stepVel;

// Prepare for input parameters
NameList nameList[] = {
  NameR(deltaT),
  NameR(density),
  NameI(initUcell),
  NameI(limitVel),
  NameI(nebrTabFac),
  NameI(randSeed),
  NameR(rangeVel),
  NameR(rNebrShell),
  NameI(sizeHistVel),
  NameI(stepAvg),
  NameI(stepEquil),
  NameI(stepLimit),
  NameI(stepVel),
  NameR(temperature),
};

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "EvalVelDist.c"
#include "SingleStep.c"

#include "PrintSummary.c"
#include "PrintVelDist.c"

int main (int argc, char **argv)
{
  GetNameList(argc, argv);
  PrintNameList(stdout);
  SetParams();
  SetupJob();
  moreCycles = 1;
  while(moreCycles) {
    SingleStep();
    if (stepCount >= stepLimit) moreCycles = 0;
  }
}

#include "in_rand.c"
#include "in_errexit.c"
#include "in_namelist.c"
