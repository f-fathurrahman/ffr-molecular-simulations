void ZeroSpacetimeCorr ()
{
  int j, n;

  countCorrAv = 0;
  for (j = 0; j < 3 * nFunCorr; j ++) {
    for (n = 0; n < nValCorr; n ++) avAcfST[j][n] = 0.;
  }
}
