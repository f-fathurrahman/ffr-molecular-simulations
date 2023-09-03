void SetupJob ()
{
  AllocArrays ();
  stepCount = 0;
  InitCoords ();
  InitVels ();
  InitAccels ();
  AccumProps (0);
  InitVacf ();
  kinEnInitSum = 0.;
  nebrNow = 1;
}
