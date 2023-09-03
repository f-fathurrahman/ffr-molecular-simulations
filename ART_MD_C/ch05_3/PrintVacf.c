void PrintVacf (FILE *fp)
{
  real tVal;
  int j;

  fprintf (fp, "acf\n");
  for (j = 0; j < nValAcf; j ++) {
    tVal = j * stepAcf * deltaT;
    fprintf (fp, "%8.4f %8.4f %8.4f %8.4f\n", tVal,
       avAcfVel[j], avAcfVisc[j], avAcfTherm[j]);
  }
  fprintf (fp, "acf integrals: %8.3f %8.3f %8.3f\n",
     intAcfVel, intAcfVisc, intAcfTherm);
  fflush (fp);
}
