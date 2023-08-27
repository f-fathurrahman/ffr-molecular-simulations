void AllocArrays ()
{
  AllocMem(mol, nMol, Mol);
  AllocMem(cellList, VProd(cells) + nMol, int);
  AllocMem(nebrTab, 2 * nebrTabMax, int);
  AllocMem(histVel, sizeHistVel, real);
}
