void ScaleCoords ()
{
  real fac;
  int n;

  fac = pow (varV, -1. / 3.);
  DO_MOL VScale (mol[n].r, fac);
}
