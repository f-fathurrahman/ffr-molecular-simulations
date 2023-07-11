void PerturbTrajDev ()
{
  VecR w;
  int n;

  for (n = 0; n < nMol; n += 2) {
    mol[n + 1].r = mol[n].r;
    VRand (&w);
    VMul (w, w, mol[n].rv);
    VSAdd (mol[n + 1].rv, mol[n].rv, pertTrajDev, w);
  }
  countTrajDev = 0;
}
