void PrintSummary (FILE *fp)
{
  fprintf(fp,
     "%5d %8.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f\n",
     stepCount, timeNow, VCSum (vSum) / nMol, PropEst (totEnergy),
     PropEst (kinEnergy), PropEst (pressure));
  fflush (fp);
}
