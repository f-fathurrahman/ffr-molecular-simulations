void InitVels ()
{
  int n;

  VZero (vSum);
  for (n = 0; n < nMol; n += 2) {
    VRand (&mol[n].rv);
    VScale (mol[n].rv, velMag);
    mol[n + 1].rv = mol[n].rv;
    VVSAdd (vSum, 2., mol[n].rv);
  }
  DO_MOL VVSAdd (mol[n].rv, - 1. / nMol, vSum);
}
