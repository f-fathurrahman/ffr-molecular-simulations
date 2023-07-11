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
  LeapfrogStep (2);
  EvalProps ();
  if (stepCount < stepEquil) AdjustInitTemp ();
  AccumProps (1);
  if (stepCount % stepAvg == 0) {
    AccumProps (2);
    PrintSummary (stdout);
    AccumProps (0);
  }
  if (stepCount == stepEquil) PerturbTrajDev ();
  if (stepCount > stepEquil && (stepCount - stepEquil) % stepTrajDev == 0) {
    MeasureTrajDev ();
    if (countTrajDev == limitTrajDev) {
      PrintTrajDev (stdout);
      PerturbTrajDev ();
      BuildNebrList ();
    }
  }
}
