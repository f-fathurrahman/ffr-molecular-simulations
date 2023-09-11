void PredictorStepBox ()
{
  real c[] = {23.,-16.,5.}, div = 12.;

  varLv = dilateRate * varL;
  varLo = varL;
  varL = varL + (deltaT / div) * (c[0] * varLv + c[1] * varLv1 +
     c[2] * varLv2);
  varLv2 = varLv1;
  varLv1 = varLv;
  dilateRate2 = dilateRate1;
  dilateRate1 = dilateRate;
  VSetAll (region, varL);
}