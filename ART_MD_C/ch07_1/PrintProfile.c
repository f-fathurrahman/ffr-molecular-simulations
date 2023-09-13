void PrintProfile (FILE *fp)
{
  real zVal;
  int n;

  fprintf (fp, "V profile\n");
  for (n = 0; n < sizeHistGrid.z; n ++) {
    zVal = (n + 0.5) / sizeHistGrid.z;
    fprintf (fp, "%.2f %.3f\n", zVal, profileV[n]);
  }
  fprintf (fp, "T profile\n");
  for (n = 0; n < sizeHistGrid.z; n ++) {
    zVal = (n + 0.5) / sizeHistGrid.z;
    fprintf (fp, "%.2f %.3f\n", zVal, profileT[n]);
  }
  fflush (fp);
}