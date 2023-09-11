void ScaleVels ()
{
  real fac;
  int n;

  fac = 1. / varL;
  DO_MOL VScale (mol[n].rv, fac);
}