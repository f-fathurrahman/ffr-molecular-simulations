void EvalRdf ()
{
  VecR dr;
  real deltaR, normFac, rr;
  int j1, j2, n;

  if (countRdf == 0) {
    for (n = 0; n < sizeHistRdf; n ++) histRdf[n] = 0.;
  }
  deltaR = rangeRdf / sizeHistRdf;
  for (j1 = 0; j1 < nMol - 1; j1 ++) {
    for (j2 = j1 + 1; j2 < nMol; j2 ++) {
      VSub (dr, mol[j1].r, mol[j2].r);
      VWrapAll (dr);
      rr = VLenSq (dr);
      if (rr < Sqr (rangeRdf)) {
        n = sqrt (rr) / deltaR;
        ++ histRdf[n];
      }
    }
  }
  ++ countRdf;
  if (countRdf == limitRdf) {
    normFac = VProd (region) / (2. * M_PI * Cube (deltaR) *
       Sqr (nMol) * countRdf);
    for (n = 0; n < sizeHistRdf; n ++)
       histRdf[n] *= normFac / Sqr (n - 0.5);
    PrintRdf (stdout);
    countRdf = 0;
  }
}
