void PrintVelDist2(FILE *fp_hist, FILE *fp_hfunc)
{
  real vBin;
  int n;

  fprintf(fp_hist, "vdist is calculated for time = %18.10f \n", timeNow);
  for(n = 0; n < sizeHistVel; n ++) {
    vBin = (n + 0.5) * rangeVel / sizeHistVel;
    fprintf(fp_hist, "%8.3f %8.3f\n", vBin, histVel[n]);
  }

  // Hfun: Boltzmann function
  fprintf(fp_hfunc, "%8.3f %8.3f\n", timeNow, hFunction);

  fflush(fp_hfunc);
  fflush(fp_hist);
}
