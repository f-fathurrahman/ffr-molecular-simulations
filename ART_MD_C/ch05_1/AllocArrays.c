void AllocArrays ()
{
  int nb;

  AllocMem (mol, nMol, Mol);
  AllocMem (cellList, VProd (cells) + nMol, int);
  AllocMem (nebrTab, 2 * nebrTabMax, int);
  AllocMem (rrDiffuseAv, nValDiffuse, real);
  AllocMem (tBuf, nBuffDiffuse, TBuf);
  for (nb = 0; nb < nBuffDiffuse; nb ++) {
    AllocMem (tBuf[nb].orgR, nMol, VecR);
    AllocMem (tBuf[nb].rTrue, nMol, VecR);
    AllocMem (tBuf[nb].rrDiffuse, nValDiffuse, real);
  }
}
