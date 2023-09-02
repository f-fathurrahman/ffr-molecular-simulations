/* [[pr_04_3 - RDF, soft spheres]] */

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
real kinEnInitSum;
int stepInitlzTemp;
real *histRdf, rangeRdf;
int countRdf, limitRdf, sizeHistRdf, stepRdf;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (limitRdf),
  NameI (nebrTabFac),
  NameR (rangeRdf),
  NameR (rNebrShell),
  NameI (sizeHistRdf),
  NameI (stepAvg),
  NameI (stepEquil),
  NameI (stepInitlzTemp),
  NameI (stepLimit),
  NameI (stepRdf),
  NameR (temperature),
};

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "AdjustInitTemp.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "EvalRdf.c"
#include "PrintRdf.c"
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
    if(stepCount >= stepLimit) moreCycles = 0;
  }
}

#include "../in_rand.c"
#include "../in_errexit.c"
#include "../in_namelist.c"
