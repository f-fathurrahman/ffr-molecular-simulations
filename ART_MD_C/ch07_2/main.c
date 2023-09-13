
/* [[pr_07_2 - heat flow]] */

#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;

Mol *mol;
VecR region, vSum;
VecI initUcell;
real deltaT, density, rCut, temperature, timeNow, uSum, velMag, vvSum;
Prop kinEnergy, totEnergy;
int moreCycles, nMol, stepAvg, stepCount, stepEquil, stepLimit;
VecI cells;
int *cellList;
real dispHi, rNebrShell;
int *nebrTab, nebrNow, nebrTabFac, nebrTabLen, nebrTabMax;
real **histGrid;
VecI sizeHistGrid;
int countGrid, limitGrid, stepGrid;
real *profileT, enTransSum, wallTempHi, wallTempLo;
Prop thermalCond;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (limitGrid),
  NameI (nebrTabFac),
  NameR (rNebrShell),
  NameI (sizeHistGrid),
  NameI (stepAvg),
  NameI (stepEquil),
  NameI (stepGrid),
  NameI (stepLimit),
  NameR (temperature),
  NameR (wallTempHi),
  NameR (wallTempLo),
};

#include "AccumProps.c"
#include "AllocArrays.c"
#include "ApplyBoundaryCond.c"
#include "BuildNebrList.c"
#include "ComputeForces.c"
#include "EvalProfile.c"
#include "EvalProps.c"
#include "GridAverage.c"
#include "InitAccels.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "LeapfrogStep.c"
#include "PrintProfile.c"
#include "PrintSummary.c"
#include "SetParams.c"
#include "SetupJob.c"
#include "SingleStep.c"


int main (int argc, char **argv)
{
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

