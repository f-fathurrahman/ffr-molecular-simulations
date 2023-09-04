void PredictorStepPT ()
{
  real cr[] = {19.,-10.,3.}, cv[] = {27.,-22.,7.}, div = 24., e, wr, wv;

  wr = Sqr (deltaT) / div;
  wv = deltaT / div;
  varSo = varS;
  varSvo = varSv;
  varVo = varV;
  varVvo = varVv;
  PCR4 (varS, varS, varSv, varSa, varSa1, varSa2);
  PCV4 (varS, varSo, varSv, varSa, varSa1, varSa2);
  PCR4 (varV, varV, varVv, varVa, varVa1, varVa2);
  PCV4 (varV, varVo, varVv, varVa, varVa1, varVa2);
  varSa2 = varSa1;
  varVa2 = varVa1;
  varSa1 = varSa;
  varVa1 = varVa;
  e = pow (varV, 1. / NDIM);
  VSetAll (region, e);
}
