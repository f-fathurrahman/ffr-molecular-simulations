void PrintSummary (FILE *fp)
{
  fprintf (fp,
     "%5d %18.10f %18.10f %18.10f %18.10f %18.10f %18.10f %18.10f %18.10f\n",
     stepCount, timeNow, VCSum (vSum) / nMol, PropEst (totEnergy),
     PropEst (kinEnergy), PropEst (pressure));
  fflush (fp);
}
