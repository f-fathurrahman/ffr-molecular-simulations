void EvalProps ()
{
  real vv;
  int n;

  VZero (vSum);
  vvSum = 0.;
  DO_MOL {
    VVAdd (vSum, mol[n].rv);
    vv = VLenSq (mol[n].rv);
    vvSum += vv;
  }
  vvSum *= pow (varV, 2./3.);
  kinEnergy.val = 0.5 * vvSum / nMol;
  totEnergy.val = kinEnergy.val + uSum / nMol;
  pressure.val = (vvSum + virSum) / (3. * varV);
  totEnergy.val += (0.5 * (massS * Sqr (varSv) +
     massV * Sqr (varVv)) / Sqr (varS) +
     extPressure * varV) / nMol;
  totEnergy.val += 3. * temperature * log (varS);
}
