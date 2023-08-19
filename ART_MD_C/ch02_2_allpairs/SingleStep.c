void SingleStep()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  LeapfrogStep (1);
  ApplyBoundaryCond ();
  ComputeForces ();
  LeapfrogStep (2);
  EvalProps ();
  AccumProps (1);
  
  // Evaluate velocity distribution here
  if( stepCount >= stepEquil && (stepCount - stepEquil) % stepVel == 0 ) {
    printf("stepCount = %d\n", stepCount);
    EvalVelDist();
  }
     
  if( stepCount % stepAvg == 0 ) {
    AccumProps(2);
    PrintSummary(summary_file);
    AccumProps(0);
  }
}
