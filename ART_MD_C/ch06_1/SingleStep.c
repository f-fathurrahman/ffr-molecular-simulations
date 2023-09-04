void SingleStep ()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  PredictorStep ();
  PredictorStepPT ();
  ApplyBoundaryCond ();
  UpdateCellSize ();
  UnscaleCoords ();
  ComputeForces ();
  ComputeDerivsPT ();
  CorrectorStep ();
  CorrectorStepPT ();
  ApplyBoundaryCond ();
  EvalProps ();
  AccumProps (1);
  if (stepCount % stepAvg == 0) {
    AccumProps (2);
    PrintSummary (stdout);
    AccumProps (0);
  }
}
