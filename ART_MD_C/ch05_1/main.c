
/* [[pr_05_1 - diffusion]] */

#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;
typedef struct {
  VecR *orgR, *rTrue;
  real *rrDiffuse;
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
real *rrDiffuseAv;
int countDiffuseAv, limitDiffuseAv, nBuffDiffuse, nValDiffuse,
   stepDiffuse;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameI (initUcell),
  NameI (limitDiffuseAv),
  NameI (nBuffDiffuse),
  NameI (nebrTabFac),
  NameI (nValDiffuse),
  NameR (rNebrShell),
  NameI (stepAvg),
  NameI (stepDiffuse),
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
#include "InitDiffusion.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "AdjustInitTemp.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "ZeroDiffusion.c"
#include "AccumDiffusion.c"
#include "EvalDiffusion.c"
#include "SingleStep.c"

#include "PrintSummary.c"
#include "PrintDiffusion.c"

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
