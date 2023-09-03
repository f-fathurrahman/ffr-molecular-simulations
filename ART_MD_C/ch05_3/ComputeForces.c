void ComputeForces ()
{
  VecR w[3], dr;
  real fcVal, rr, rrCut, rri, rri3, uVal;
  int j1, j2, n;
  int k;

  rrCut = Sqr (rCut);
  DO_MOL VZero (mol[n].ra);
  uSum = 0.;
  virSum = 0.;
  DO_MOL {
    mol[n].en = 0.;
    for (k = 0; k < 3; k ++) VZero (mol[n].rf[k]);
  }
  for (n = 0; n < nebrTabLen; n ++) {
    j1 = nebrTab[2 * n];
    j2 = nebrTab[2 * n + 1];
    VSub (dr, mol[j1].r, mol[j2].r);
    VWrapAll (dr);
    rr = VLenSq (dr);
    if (rr < rrCut) {
      rri = 1. / rr;
      rri3 = Cube (rri);
      fcVal = 48. * rri3 * (rri3 - 0.5) * rri;
      uVal = 4. * rri3 * (rri3 - 1.) + 1.;
      VVSAdd (mol[j1].ra, fcVal, dr);
      VVSAdd (mol[j2].ra, - fcVal, dr);
      uSum += uVal;
      virSum += fcVal * rr;
      mol[j1].en += uVal;
      mol[j2].en += uVal;
      for (k = 0; k < 3; k ++) w[k] = dr;
      VScale (w[0], fcVal * dr.x);
      VScale (w[1], fcVal * dr.y);
      VScale (w[2], fcVal * dr.z);
      for (k = 0; k < 3; k ++) {
        VVAdd (mol[j1].rf[k], w[k]);
        VVAdd (mol[j2].rf[k], w[k]);
      }
    }
  }
}
