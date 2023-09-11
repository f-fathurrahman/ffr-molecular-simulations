void ApplyThermostat ()
{
  real s1, s2, vFac;
  int n;

  s1 = s2 = 0.;
  DO_MOL {
    s1 += VDot (mol[n].rv, mol[n].ra);
    s2 += VLenSq (mol[n].rv);
  }
  vFac = - s1 / s2;
  DO_MOL
     VSSAdd (mol[n].ra, 1. / varL, mol[n].ra,
        vFac / varL - dilateRate, mol[n].rv);
}