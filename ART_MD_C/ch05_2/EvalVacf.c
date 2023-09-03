void EvalVacf ()
{
  int n, nb, ni;

  for (nb = 0; nb < nBuffAcf; nb ++) {
    if (tBuf[nb].count == 0) {
      DO_MOL tBuf[nb].orgVel[n] = mol[n].rv;
    }
    if (tBuf[nb].count >= 0) {
      ni = tBuf[nb].count;
      tBuf[nb].acfVel[ni] = 0.;
      DO_MOL tBuf[nb].acfVel[ni] += VDot (tBuf[nb].orgVel[n], mol[n].rv);
    }
    ++ tBuf[nb].count;
  }
  AccumVacf ();
}
