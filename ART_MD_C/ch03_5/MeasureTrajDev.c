void MeasureTrajDev ()
{
  VecR dr;
  real dSum;
  int n;

  dSum = 0.;
  for (n = 0; n < nMol; n += 2) {
    VSub (dr, mol[n + 1].r, mol[n].r);
    VWrapAll (dr);
    dSum += VLenSq (dr);
  }
  valTrajDev[countTrajDev] = sqrt (dSum / (0.5 * nMol));
  ++ countTrajDev;
}
