void SetupFiles ()
{
  FILE *fp;

  strcpy (fileName[FL_SNAP], fileNameR[FL_SNAP]);
  fileName[FL_SNAP][0] = progId[0];
  fileName[FL_SNAP][1] = progId[1];
  fileName[FL_SNAP][2] = runId / 10 + CHAR_ZERO;
  fileName[FL_SNAP][3] = runId % 10 + CHAR_ZERO;
  fp = fopen (fileName[FL_SNAP], "w");
  fclose (fp);
}
