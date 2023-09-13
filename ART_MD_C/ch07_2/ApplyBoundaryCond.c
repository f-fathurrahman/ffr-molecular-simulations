void ApplyBoundaryCond ()
{
  real vNew, vSign, vvNew, vvOld;
  int n;

  enTransSum = 0.;
  DO_MOL {
    VWrap (mol[n].r, x);
    VWrap (mol[n].r, y);
    vSign = 0.;
    if (mol[n].r.z >= 0.5 * region.z) vSign = 1.;
    else if (mol[n].r.z  < -0.5 * region.z) vSign = -1.;
    if (vSign != 0.) {
      mol[n].r.z  = 0.49999 * vSign * region.z;
      vvOld = VLenSq (mol[n].rv);
      vNew = sqrt (NDIM * ((vSign < 0.) ? wallTempHi : wallTempLo));
      VRand (&mol[n].rv);
      VScale (mol[n].rv, vNew);
      vvNew = VLenSq (mol[n].rv);
      enTransSum += 0.5 * vSign * (vvNew - vvOld);
      if (mol[n].rv.z * vSign > 0.) mol[n].rv.z *= -1.;
    }
  }
}
