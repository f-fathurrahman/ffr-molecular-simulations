void SingleStep ()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  LeapfrogStep (1);
  ApplyBoundaryCond ();
  if (nebrNow) {
    nebrNow = 0;
    dispHi = 0.;
    BuildNebrList ();
  }
  ComputeForces ();
  ComputeExternalForce ();
  LeapfrogStep (2);
  EvalProps ();
  AccumProps (1);
  if (stepCount % stepAvg == 0) {
    AccumProps (2);
    PrintSummary (stdout);
    AccumProps (0);
  }
  if (stepCount >= stepEquil && (stepCount - stepEquil) % stepGrid == 0) {
    ++ countGrid;
    GridAverage (1);
    if (countGrid % limitGrid == 0) {
      GridAverage (2);
      EvalProfile ();
      PrintProfile (stdout);
      GridAverage (0);
    }
  }
}