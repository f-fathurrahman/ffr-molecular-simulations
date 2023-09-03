void AllocArrays ()
{
  int nb;

  AllocMem (mol, nMol, Mol);
  AllocMem (cellList, VProd (cells) + nMol, int);
  AllocMem (nebrTab, 2 * nebrTabMax, int);
  AllocMem (avAcfVel, nValAcf, real);
  AllocMem (tBuf, nBuffAcf, TBuf);
  for (nb = 0; nb < nBuffAcf; nb ++) {
    AllocMem (tBuf[nb].acfVel, nValAcf, real);
    AllocMem (tBuf[nb].orgVel, nMol, VecR);
  }
}
