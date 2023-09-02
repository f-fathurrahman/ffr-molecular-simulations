void EvalLatticeCorr ()
{
  VecR kVec;
  real si, sr, t;
  int n;

  kVec.x = 2. * M_PI * initUcell.x / region.x;
  kVec.y = - kVec.x;
  kVec.z = kVec.x;
  sr = 0.;
  si = 0.;
  DO_MOL {
    t = VDot (kVec, mol[n].r);
    sr += cos (t);
    si += sin (t);
  }
  latticeCorr = sqrt (Sqr (sr) + Sqr (si)) / nMol;
}
