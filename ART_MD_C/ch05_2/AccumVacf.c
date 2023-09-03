void AccumVacf ()
{
  real fac;
  int j, nb;

  for (nb = 0; nb < nBuffAcf; nb ++) {
    if (tBuf[nb].count == nValAcf) {
      for (j = 0; j < nValAcf; j ++) avAcfVel[j] += tBuf[nb].acfVel[j];
      tBuf[nb].count = 0;
      ++ countAcfAv;
      if (countAcfAv == limitAcfAv) {
        fac = stepAcf * deltaT / (NDIM * nMol * limitAcfAv);
        intAcfVel = fac * Integrate (avAcfVel, nValAcf);
        for (j = 1; j < nValAcf; j ++) avAcfVel[j] /= avAcfVel[0];
        avAcfVel[0] = 1.;
        PrintVacf (stdout);
        ZeroVacf ();
      }
    }
  }
}
