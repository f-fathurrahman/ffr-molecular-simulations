
/* [[pr_05_4 - space-time correlations]] */

#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;
typedef struct {
  real **acfST, *orgST;
  int count;
} TBuf;

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
TBuf *tBuf;
real **avAcfST, *valST;
int countCorrAv, limitCorrAv, nBuffCorr, nFunCorr, nValCorr, stepCorr;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (limitCorrAv),
  NameI (nBuffCorr),
  NameI (nebrTabFac),
  NameI (nFunCorr),
  NameI (nValCorr),
  NameR (rNebrShell),
  NameI (stepAvg),
  NameI (stepCorr),
  NameI (stepEquil),
  NameI (stepInitlzTemp),
  NameI (stepLimit),
  NameR (temperature),
};

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "InitSpacetimeCorr.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "AdjustInitTemp.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "ZeroSpacetimeCorr.c"
#include "AccumSpacetimeCorr.c"
#include "EvalSpacetimeCorr.c"
#include "SingleStep.c"

#include "PrintSummary.c"
#include "PrintSpacetimeCorr.c"

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
