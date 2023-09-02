void PrintRdf (FILE *fp)
{
  real rb;
  int n;

  fprintf (fp, "rdf\n");
  for (n = 0; n < sizeHistRdf; n ++) {
    rb = (n + 0.5) * rangeRdf / sizeHistRdf;
    fprintf (fp, "%8.4f %8.4f\n", rb, histRdf[n]);
  }
  fflush (fp);
}
