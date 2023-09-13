
/* [[pr_07_1 - pipe flow]] */

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
VecI sizeHistGrid;
real **histGrid;
int countGrid, limitGrid, stepGrid;
real *profileT, *profileV, gravField;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameR (gravField),
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
};


#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "SetupJob.c"

#include "ComputeExternalForce.c"
#include "LeapfrogStep.c"
#include "BuildNebrList.c"
#include "GridAverage.c"
#include "EvalProfile.c"
#include "PrintProfile.c"

#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
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
  moreCycles = 1;
  while(moreCycles) {
    SingleStep();
    if (stepCount >= stepLimit) moreCycles = 0;
  }
}

#include "../in_rand.c"
#include "../in_errexit.c"
#include "../in_namelist.c"

