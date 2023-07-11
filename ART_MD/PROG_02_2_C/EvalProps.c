void EvalProps ()
{
  real vv, vvMax;
  int n;

  VZero(vSum);
  vvSum = 0.0;
  vvMax = 0.0;
  DO_MOL {
    VVAdd(vSum, mol[n].rv);
    vv = VLenSq(mol[n].rv);
    vvSum += vv;
    vvMax = Max(vvMax, vv);
  }
  dispHi += sqrt (vvMax) * deltaT;
  if( dispHi > 0.5 * rNebrShell ) nebrNow = 1;
  kinEnergy.val = 0.5 * vvSum / nMol;
  totEnergy.val = kinEnergy.val + uSum / nMol;
}

