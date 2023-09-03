void InitSpacetimeCorr ()
{
  int nb;

  for (nb = 0; nb < nBuffCorr; nb ++)
     tBuf[nb].count = - nb * nValCorr / nBuffCorr;
  ZeroSpacetimeCorr ();
}
