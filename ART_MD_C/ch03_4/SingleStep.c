void SingleStep ()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  if (nebrNow) {
    nebrNow = 0;
    dispHi = 0.;
    BuildNebrList ();
  }
  PredictorStep ();
  ComputeForces ();
  CorrectorStep ();
  ApplyBoundaryCond ();
  EvalProps ();
  if (stepCount < stepEquil) AdjustInitTemp ();
  AccumProps (1);
  if (stepCount % stepAvg == 0) {
    AccumProps (2);
    PrintSummary (stdout);
    AccumProps (0);
  }
}
