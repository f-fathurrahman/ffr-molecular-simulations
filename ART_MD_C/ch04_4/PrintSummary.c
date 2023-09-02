void PrintSummary (FILE *fp)
{
  fprintf (fp,
     "%5d %8.4f %7.4f %7.4f %7.4f %7.4f %7.4f",
     stepCount, timeNow, VCSum (vSum) / nMol, PropEst (totEnergy),
     PropEst (kinEnergy));
  fprintf (fp, " %7.4f", latticeCorr);
  fprintf (fp, "\n");
  fflush (fp);
}
