void InitVacf ()
{
  int nb;

  for (nb = 0; nb < nBuffAcf; nb ++)
     tBuf[nb].count = - nb * nValAcf / nBuffAcf;
  ZeroVacf ();
}
