void ZeroVacf ()
{
  int j;

  countAcfAv = 0;
  for (j = 0; j < nValAcf; j ++) avAcfVel[j] = 0.;
  for (j = 0; j < nValAcf; j ++) {
    avAcfVisc[j] = 0.;
    avAcfTherm[j] = 0.;
  }
}
