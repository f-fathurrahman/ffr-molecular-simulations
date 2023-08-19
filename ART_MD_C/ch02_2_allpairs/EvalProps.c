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

  kinEnergy.val = 0.5 * vvSum / nMol;
  totEnergy.val = kinEnergy.val + uSum / nMol;
}

