void SingleStep ()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  LeapfrogStep (1);
  ApplyBoundaryCond ();
  ComputeForces ();
  LeapfrogStep (2);
  EvalProps ();
  AccumProps (1);
  if (stepCount % stepAvg == 0 || stepCount == 1) {
    AccumProps (2);
    PrintSummary (stdout);
    AccumProps (0);
  }
}
