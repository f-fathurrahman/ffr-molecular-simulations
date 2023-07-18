/* [[pr_02_1 - all pairs, two dimensions]] */

#include <time.h>

#define NDIM  2

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
real virSum;
Prop pressure;

NameList nameList[] = {
  NameR(deltaT),
  NameR(density),
  NameI(initUcell),
  NameI(stepAvg),
  NameI(stepEquil),
  NameI(stepLimit),
  NameR(temperature),
};

#include "SetupJob.c"
#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"

#include "LeapfrogStep.c"
#include "ComputeForces.c"
#include "ApplyBoundaryCond.c"
#include "EvalProps.c"
#include "AccumProps.c"

#include "PrintSummary.c"

void my_single_step()
{
  ++stepCount;
  timeNow = stepCount * deltaT;
  LeapfrogStep(1);
  ApplyBoundaryCond();
  ComputeForces();
  LeapfrogStep(2);
  EvalProps();
  
  // Print out total energy
  if( stepCount % 10 == 0 ) {
    printf("%18.10f ", timeNow);
    printf("%18.10f ", totEnergy.val);
    printf("%18.10f ", kinEnergy.val);
    printf("%18.10f ", pressure.val);
    printf("\n");
  }
}

int main( int argc, char **argv )
{
  clock_t begin_time = clock();

  GetNameList(argc, argv);

  PrintNameList(stdout);
  
  SetParams();
  
  SetupJob();
  
  // MD steps
  moreCycles = 1;
  while( moreCycles ) {
    my_single_step();
    if( stepCount >= stepLimit ) moreCycles = 0;
  }

  clock_t end_time = clock();

  double time_spent = (double)(end_time - begin_time)/CLOCKS_PER_SEC;
  printf("\ntime_spent = %f seconds\n", time_spent);

  return 0;
}

#include "../in_rand.c"
#include "../in_errexit.c"
#include "../in_namelist.c"
