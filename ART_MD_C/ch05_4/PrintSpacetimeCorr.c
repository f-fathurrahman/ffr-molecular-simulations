void PrintSpacetimeCorr (FILE *fp)
{
  real tVal;
  int j, k, n;
  char *header[] = {"cur-long", "cur-trans", "density"};

  fprintf (fp, "space-time corr\n");
  for (k = 0; k < 3; k ++) {
    fprintf (fp, "%s\n", header[k]);
    for (n = 0; n < nValCorr; n ++) {
      tVal = n * stepCorr * deltaT;
      fprintf (fp, "%7.3f", tVal);
      for (j = 0; j < nFunCorr; j ++)
         fprintf (fp, " %8.4f", avAcfST[3 * j + k][n]);
      fprintf (fp, "\n");
    }
  }
  fflush (fp);
}
