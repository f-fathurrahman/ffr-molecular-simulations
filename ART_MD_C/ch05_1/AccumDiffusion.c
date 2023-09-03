void AccumDiffusion ()
{
  real fac;
  int j, nb;

  for (nb = 0; nb < nBuffDiffuse; nb ++) {
    if (tBuf[nb].count == nValDiffuse) {
      for (j = 0; j < nValDiffuse; j ++)
         rrDiffuseAv[j] += tBuf[nb].rrDiffuse[j];
      tBuf[nb].count = 0;
      ++ countDiffuseAv;
      if (countDiffuseAv == limitDiffuseAv) {
        fac = 1. / (NDIM * 2 * nMol * stepDiffuse *
           deltaT * limitDiffuseAv);
        for (j = 1; j < nValDiffuse; j ++)
           rrDiffuseAv[j] *= fac / j;
        PrintDiffusion (stdout);
        ZeroDiffusion ();
      }
    }
  }
}
