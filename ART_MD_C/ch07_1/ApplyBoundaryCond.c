void ApplyBoundaryCond ()
{
  real vSign;
  int n;

  DO_MOL {
    VWrap (mol[n].r, x);
    VWrap (mol[n].r, y);
    vSign = 0.;
    if (mol[n].r.z >= 0.5 * region.z) vSign = 1.;
    else if (mol[n].r.z  < -0.5 * region.z) vSign = -1.;
    if (vSign != 0.) {
      mol[n].r.z  = 0.49999 * vSign * region.z;
      VRand (&mol[n].rv);
      VScale (mol[n].rv, velMag);
      if (mol[n].rv.z * vSign > 0.) mol[n].rv.z *= -1.;
    }
  }
}
