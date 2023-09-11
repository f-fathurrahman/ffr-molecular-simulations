void UnscaleCoords ()
{
  real fac;
  int  n;

  fac = varL;
  DO_MOL VScale (mol[n].r, fac);
}