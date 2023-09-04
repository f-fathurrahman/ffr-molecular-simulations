void AllocArrays ()
{
  AllocMem (mol, nMol, Mol);
  AllocMem (cellList, Cube (maxEdgeCells) + nMol, int);
}
