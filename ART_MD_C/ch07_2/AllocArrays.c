void AllocArrays ()
{
  int k;

  AllocMem (mol, nMol, Mol);
  AllocMem (cellList, VProd (cells) + nMol, int);
  AllocMem (nebrTab, 2 * nebrTabMax, int);
  AllocMem2 (histGrid, NHIST, VProd (sizeHistGrid), real);
  AllocMem (profileT, sizeHistGrid.z, real);
}