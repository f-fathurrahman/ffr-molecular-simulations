void ComputeDerivsPT ()
{
  real aFac, vFac;
  int n;

  vvSum = 0.;
  DO_MOL vvSum += VLenSq (mol[n].rv);
  vvSum *= pow (varV, 2./3.);
  g1Sum = vvSum - 3. * nMol * temperature;
  g2Sum = vvSum + virSum - 3. * extPressure * varV;
  aFac = pow (varV, -1./3.);
  vFac = - varSv / varS - 2. * varVv / (3. * varV);
  DO_MOL VSSAdd (mol[n].ra, aFac, mol[n].ra, vFac, mol[n].rv);
  varSa = Sqr (varSv) / varS + g1Sum * varS / massS;
  varVa = varSv * varVv / varS +
     g2Sum * Sqr (varS) / (3. * massV * varV);
}
