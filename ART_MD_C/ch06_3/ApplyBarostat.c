void ApplyBarostat ()
{
  real vvS;
  int n;

  vvS = 0.;
  DO_MOL vvS += VLenSq (mol[n].rv);
  dilateRate = - dvirSum1 * varL / (3. * (vvS * Sqr (varL) +
     virSum) + dvirSum2);
}