void AllocArrays ()
{
  int k, nb;

  AllocMem (mol, nMol, Mol);
  AllocMem (cellList, VProd (cells) + nMol, int);
  AllocMem (nebrTab, 2 * nebrTabMax, int);
  AllocMem (valST, 24 * nFunCorr, real);
  AllocMem2 (avAcfST, 3 * nFunCorr, nValCorr, real);
  AllocMem (tBuf, nBuffCorr, TBuf);
  for (nb = 0; nb < nBuffCorr; nb ++) {
    AllocMem (tBuf[nb].orgST, 24 * nFunCorr, real);
    AllocMem2 (tBuf[nb].acfST, 3 * nFunCorr, nValCorr, real);
  }
}
