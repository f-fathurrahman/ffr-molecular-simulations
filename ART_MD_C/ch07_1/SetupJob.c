void SetupJob ()
{
  AllocArrays ();
  stepCount = 0;
  InitCoords ();
  InitVels ();
  InitAccels ();
  AccumProps (0);
  nebrNow = 1;
  GridAverage (0);
  countGrid = 0;
}