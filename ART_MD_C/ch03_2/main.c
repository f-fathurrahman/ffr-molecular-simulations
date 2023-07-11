/* [[pr_03_2 - neighbor list and leapfrog]] */

#include "../in_mddefs.h"

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
real virSum;
Prop pressure;
real kinEnInitSum;
int stepInitlzTemp;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (nebrTabFac),
  NameI (randSeed),
  NameR (rNebrShell),
  NameI (stepAvg),
  NameI (stepEquil),
  NameI (stepInitlzTemp),
  NameI (stepLimit),
  NameR (temperature),
};

#include "SetupJob.c"
#include "SetParams.c"
#include "LeapfrogStep.c"
#include "ComputeForces.c"
#include "AllocArrays.c"
#include "BuildNebrList.c"
#include "ApplyBoundaryCond.c"
#include "AdjustInitTemp.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "SingleStep.c"

#include "PrintSummary.c"

int main (int argc, char **argv)
{

  printf("NDIM = %d\n", NDIM);

  GetNameList (argc, argv);
  PrintNameList (stdout);
  SetParams ();
  SetupJob ();
  moreCycles = 1;
  while (moreCycles) {
    SingleStep ();
    if (stepCount >= stepLimit) moreCycles = 0;
  }
}

#include "../in_rand.c"
#include "../in_errexit.c"
#include "../in_namelist.c"
