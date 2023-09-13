void AccumProps (int icode)
{
  if (icode == 0) {
    PropZero (totEnergy);
    PropZero (kinEnergy);
    PropZero (thermalCond);
  } else if (icode == 1) {
    PropAccum (totEnergy);
    PropAccum (kinEnergy);
    PropAccum (thermalCond);
  } else if (icode == 2) {
    PropAvg (totEnergy, stepAvg);
    PropAvg (kinEnergy, stepAvg);
    PropAvg (thermalCond, stepAvg);
  }
}