void InitDiffusion ()
{
  int nb;

  for (nb = 0; nb < nBuffDiffuse; nb ++)
     tBuf[nb].count = - nb * nValDiffuse / nBuffDiffuse;
  ZeroDiffusion ();
}
