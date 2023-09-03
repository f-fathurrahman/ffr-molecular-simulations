
/* [[pr_05_2 - velocity autocorrelation function]] */

#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;
typedef struct {
  VecR *orgVel;
  real *acfVel;
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
real *avAcfVel, intAcfVel;
int countAcfAv, limitAcfAv, nBuffAcf, nValAcf, stepAcf;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (limitAcfAv),
  NameI (nBuffAcf),
  NameI (nebrTabFac),
  NameI (nValAcf),
  NameR (rNebrShell),
  NameI (stepAcf),
  NameI (stepAvg),
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
#include "InitVacf.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "AdjustInitTemp.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "ZeroVacf.c"
#include "Integrate.c"
#include "AccumVacf.c"
#include "EvalVacf.c"
#include "SingleStep.c"

#include "PrintSummary.c"
#include "PrintVacf.c"

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
