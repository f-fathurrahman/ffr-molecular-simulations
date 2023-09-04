
/* [[pr_06_1 - feedback PT]] */

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
real extPressure, g1Sum, g2Sum, massS, massV, varS, varSa, varSa1, varSa2,
   varSo, varSv, varSvo, varV, varVa, varVa1, varVa2, varVo, varVv, varVvo;
int maxEdgeCells;

NameList nameList[] = {
  NameR (deltaT),
  NameR (density),
  NameR (extPressure),
  NameI (initUcell),
  NameR (massS),
  NameR (massV),
  NameI (stepAvg),
  NameI (stepEquil),
  NameI (stepLimit),
  NameR (temperature),
};

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "SetupJob.c"

#include "pc_macros.c"
#include "PredictorStep.c"
#include "CorrectorStep.c"
#include "pc_macrosPT.c"
#include "PredictorStepPT.c"
#include "CorrectorStepPT.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "InitFeedbackVars.c"
#include "ScaleCoords.c"
#include "ScaleVels.c"
#include "UpdateCellSize.c"
#include "UnscaleCoords.c"
#include "ComputeDerivsPT.c"
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
