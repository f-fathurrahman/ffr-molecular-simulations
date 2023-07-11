void PrintTrajDev (FILE *fp)
{
  real tVal;
  int n;

  for (n = 0; n < limitTrajDev; n ++) {
    tVal = (n + 1) * stepTrajDev * deltaT;
    fprintf (fp, "%.4e %.4e\n", tVal, valTrajDev[n]);
  }
  fflush (fp);
}
