/* [[pr_02_2 - velocity distribution]] */

#define NDIM  2

// Macros and several definitions
#include "../in_mddefs.h"

typedef struct {
  VecR r, rv, ra;
} Mol;


//
// These are global variables
//
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
real *histVel, hFunction, rangeVel;
int countVel, limitVel, sizeHistVel, stepVel;

// Prepare for input parameters
NameList nameList[] = {
  NameR(deltaT),
  NameR(density),
  NameI(initUcell),
  NameI(limitVel),
  NameI(nebrTabFac),
  NameI(randSeed),
  NameR(rangeVel),
  NameR(rNebrShell),
  NameI(sizeHistVel),
  NameI(stepAvg),
  NameI(stepEquil),
  NameI(stepLimit),
  NameI(stepVel),
  NameR(temperature),
};

// Output files, make them global variables
FILE *summary_file;
FILE *veldist_file;
FILE *hfunc_file;

#include "SetParams.c"
#include "AllocArrays.c"
#include "InitCoords.c"
#include "InitVels.c"
#include "InitAccels.c"
#include "SetupJob.c"

#include "BuildNebrList.c"
#include "LeapfrogStep.c"
#include "ApplyBoundaryCond.c"
#include "ComputeForces.c"
#include "EvalProps.c"
#include "AccumProps.c"
#include "EvalVelDist.c"
#include "SingleStep.c"

#include "PrintSummary.c"
#include "PrintVelDist.c"

int main (int argc, char **argv)
{
  GetNameList(argc, argv);
  
  summary_file = fopen("SUMMARY.dat", "w");
  veldist_file = fopen("VELDIST.dat", "w");
  hfunc_file = fopen("HFUNC.dat", "w");

  PrintNameList(stdout);
  SetParams();
  SetupJob();

  //
  // Do something other than SingleStep here
  //

  // Build neighbor list
  VecR dr, invWid, rs, shift;
  VecI cc, m1v, m2v, vOff[] = OFFSET_VALS;
  real rrNebr;
  int c, j1, j2, m1, m1x, m1y, m2, n, offset;


  rrNebr = Sqr(rCut + rNebrShell);

  VDiv(invWid, cells, region);
  printf("region = [%f,%f]\n", region.x, region.y);
  printf("invWid = [%f,%f]\n", invWid.x, invWid.y);
  
  // Initialize cellList to invalid values
  for(n = nMol; n < nMol + VProd (cells); n++) cellList[n] = -1;
  
  DO_MOL {

    /*
    #define VSAdd(v1, v2, s3, v3)   \
   (v1).x = (v2).x + (s3) * (v3).x,  \
   (v1).y = (v2).y + (s3) * (v3).y
    */

    VSAdd(rs, mol[n].r, 0.5, region);

    VMul(cc, rs, invWid);
    c = VLinear(cc, cells) + nMol;
    printf("\nn = %d\n", n);
    printf("r = [%f,%f] rs = [%f,%f] cc = [%d,%d] c = %d\n",
      mol[n].r.x, mol[n].r.y, rs.x, rs.y, cc.x, cc.y, c);
    cellList[n] = cellList[c];
    cellList[c] = n;
  }

  printf("\n");
  printf("------------------------\n");
  printf("Final result of cellList\n");
  printf("------------------------\n");
  int i;
  int NcellList = VProd(cells) + nMol;
  for(i = 0; i < NcellList; i++) {
    printf("%3d %3d\n", i, cellList[i]);
  }


  nebrTabLen = 0;
  for( m1y = 0; m1y < cells.y; m1y++ ) {
    for( m1x = 0; m1x < cells.x; m1x++ ) {
      VSet(m1v, m1x, m1y);
      m1 = VLinear(m1v, cells) + nMol; // linear index of first cell
      printf("\n[%d %d]: m1 = %d\n", m1x, m1y, m1);
      for( offset = 0; offset < N_OFFSET; offset ++ ) {
      //for( offset = 0; offset < 1; offset++ ) { // DEBUG: check only for 1 offset
        printf("\noffset = %d\n", offset);
        VAdd(m2v, m1v, vOff[offset]);
        VZero(shift); // set shift to zeros
        
        VCellWrapAll();
        // this will access variables: m2v, cells, shift, region

        m2 = VLinear(m2v, cells) + nMol; // linear index of second cell
        printf("m2 = %d\n", m2);
        printf("\nBegin outer cell loop\n");
        DO_CELL(j1, m1) {
          printf("\nj1 = %d cellList[j1] = %d, m1 = %d\n", j1, cellList[j1], m1);
          printf("Next j1 = %d\n", cellList[j1]);
          printf("Begin inner cell loop\n");
          DO_CELL(j2, m2) {
            printf("\nj2 = %d cellList[j2] = %d, m2 = %d\n", j2, cellList[j2], m2);
            printf("Next j2 = %d\n", cellList[j2]);
            if (m1 != m2 || j2 < j1) {
              printf("nebrTab is updated: m1,m2=[%d,%d], j1,j2=[%d,%d]\n", m1, m2, j1, j2);
              VSub(dr, mol[j1].r, mol[j2].r);
              VVSub(dr, shift);
              if( VLenSq(dr) < rrNebr ) {
                if( nebrTabLen >= nebrTabMax ) {
                  ErrExit(ERR_TOO_MANY_NEBRS);
                }
                nebrTab[2 * nebrTabLen] = j1;
                nebrTab[2 * nebrTabLen + 1] = j2;
                ++nebrTabLen;
              }
            }
          }
        }
      }
    }
  }


  printf("nebrTabLen = %d\n", nebrTabLen);

  for (n = 0; n < nebrTabLen; n ++) {
    j1 = nebrTab[2 * n];
    j2 = nebrTab[2 * n + 1];
    printf("n = %3d atoms pair: (%3d %3d)\n", n, j1, j2);
  }


/*  for (m1y = 0; m1y < cells.y; m1y ++) {
    for (m1x = 0; m1x < cells.x; m1x ++) {
      VSet(m1v, m1x, m1y);
      m1 = VLinear(m1v, cells) + nMol;
      printf("\n[%d %d]: m1 = %d\n", m1x, m1y, m1);
      //#define DO_CELL(j, m)  for (j = cellList[m]; j >= 0; j = cellList[j])
      printf("Will loop from j1 = %d, until cellList[j1] >=0\n", cellList[m1]);
      //printf("cellList[j1]\n");
      DO_CELL(j1, m1) {
        printf("j1 = %d cellList[j1] = %d, m1 = %d\n", j1, cellList[j1], m1);
        printf("Next j = %d\n", cellList[j1]);
        DO_CELL (j2, m2) {
          if (m1 != m2 || j2 < j1) {
            VSub(dr, mol[j1].r, mol[j2].r);
            VVSub(dr, shift);
            if (VLenSq (dr) < rrNebr) {
              if( nebrTabLen >= nebrTabMax ) {
                ErrExit (ERR_TOO_MANY_NEBRS);
              }
              nebrTab[2 * nebrTabLen] = j1;
              nebrTab[2 * nebrTabLen + 1] = j2;
              ++nebrTabLen;
            }
          }
        }
      }
    }
  }
*/



  // Close the files
  fclose(summary_file);
  fclose(veldist_file);
  fclose(hfunc_file);
}

#include "../in_rand.c"
#include "../in_errexit.c"
#include "../in_namelist.c"

