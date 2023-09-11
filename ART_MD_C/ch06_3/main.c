
/* [[pr_06_3 - constrained PT]] */

#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra, ra1, ra2, ro, rvo;
} Mol;

Mol *mol;
VecR region, vSum;
VecI initUcell;
real deltaT, density, rCut, temperature, timeNow, uSum, velMag, vvSum;
Prop kinEnergy, totEnergy;
int moreCycles, nMol, stepAvg, stepCount, stepEquil, stepLimit;
VecI cells;
int *cellList;
real virSum;
Prop pressure;
real dilateRate, dilateRate1, dilateRate2, dvirSum1, dvirSum2,
   extPressure, tolPressure, varL, varLo, varLv, varLv1, varLv2;
int maxEdgeCells, nPressCycle, stepAdjustPress;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameR (extPressure),
  NameI (initUcell),
  NameI (stepAdjustPress),
  NameI (stepAvg),
  NameI (stepEquil),
  NameI (stepLimit),
  NameR (temperature),
  NameR (tolPressure),
};

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "InitBoxVars.c"
#include "SetupJob.c"

#include "pc_macros.c"
#include "PredictorStep.c"
#include "PredictorStepBox.c"
#include "CorrectorStep.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "ScaleCoords.c"
#include "ScaleVels.c"
#include "UpdateCellSize.c"
#include "UnscaleCoords.c"
#include "ApplyBarostat.c"
#include "ApplyThermostat.c"
#include "CorrectorStepBox.c"
#include "AdjustPressure.c"
#include "AdjustTemp.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "SingleStep.c"

#include "PrintSummary.c"


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
