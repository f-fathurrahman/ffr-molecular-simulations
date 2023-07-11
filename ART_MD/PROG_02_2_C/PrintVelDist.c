void PrintVelDist (FILE *fp)
{
  real vBin;
  int n;

  printf ("vdist (%.3f)\n", timeNow);
  for (n = 0; n < sizeHistVel; n ++) {
    vBin = (n + 0.5) * rangeVel / sizeHistVel;
    fprintf (fp, "%8.3f %8.3f\n", vBin, histVel[n]);
  }
  fprintf (fp, "hfun: %8.3f %8.3f\n", timeNow, hFunction);
  fflush (fp);
}
