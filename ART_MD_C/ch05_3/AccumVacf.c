void AccumVacf ()
{
  real fac;
  int j, nb;

  for (nb = 0; nb < nBuffAcf; nb ++) {
    if (tBuf[nb].count == nValAcf) {
      for (j = 0; j < nValAcf; j ++) avAcfVel[j] += tBuf[nb].acfVel[j];
      for (j = 0; j < nValAcf; j ++) {
        avAcfVisc[j] += tBuf[nb].acfVisc[j];
        avAcfTherm[j] += tBuf[nb].acfTherm[j];
      }
      tBuf[nb].count = 0;
      ++ countAcfAv;
      if (countAcfAv == limitAcfAv) {
        fac = stepAcf * deltaT / (NDIM * nMol * limitAcfAv);
        intAcfVel = fac * Integrate (avAcfVel, nValAcf);
        for (j = 1; j < nValAcf; j ++) avAcfVel[j] /= avAcfVel[0];
        avAcfVel[0] = 1.;
        fac = density * stepAcf * deltaT /
           (3. * temperature * nMol * limitAcfAv);
        intAcfVisc = fac * Integrate (avAcfVisc, nValAcf);
        for (j = 1; j < nValAcf; j ++) avAcfVisc[j] /= avAcfVisc[0];
        avAcfVisc[0] = 1.;
        fac = density * stepAcf * deltaT /
           (3. * Sqr (temperature) * nMol * limitAcfAv);
        intAcfTherm = fac * Integrate (avAcfTherm, nValAcf);
        for (j = 1; j < nValAcf; j ++) avAcfTherm[j] /= avAcfTherm[0];
        avAcfTherm[0] = 1.;
        PrintVacf (stdout);
        ZeroVacf ();
      }
    }
  }
}
