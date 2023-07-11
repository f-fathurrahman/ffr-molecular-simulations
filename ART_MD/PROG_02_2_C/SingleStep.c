void SingleStep ()
{
  ++ stepCount;
  timeNow = stepCount * deltaT;
  LeapfrogStep(1);
  ApplyBoundaryCond();
  if( nebrNow ) {
    nebrNow = 0;
    dispHi = 0.0;
    BuildNebrList();
  }
  ComputeForces();
  LeapfrogStep(2);
  EvalProps();
  AccumProps(1);
  if( stepCount >= stepEquil && (stepCount - stepEquil) % stepVel == 0 )
     EvalVelDist();
  if( stepCount % stepAvg == 0 ) {
    AccumProps(2);
    PrintSummary(stdout);
    AccumProps(0);
  }
}
