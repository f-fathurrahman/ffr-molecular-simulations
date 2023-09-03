void PrintDiffusion (FILE *fp)
{
  real tVal;
  int j;

  fprintf (fp, "diffusion\n");
  for (j = 0; j < nValDiffuse; j ++) {
    tVal = j * stepDiffuse * deltaT;
   fprintf (fp, "%8.4f %8.4f\n", tVal, rrDiffuseAv[j]);
  }
  fflush (fp);
}
