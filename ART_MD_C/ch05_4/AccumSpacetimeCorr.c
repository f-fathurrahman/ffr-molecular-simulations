void AccumSpacetimeCorr ()
{
  int j, n, nb;

  for (nb = 0; nb < nBuffCorr; nb ++) {
    if (tBuf[nb].count == nValCorr) {
      for (j = 0; j < 3 * nFunCorr; j ++) {
        for (n = 0; n < nValCorr; n ++)
           avAcfST[j][n] += tBuf[nb].acfST[j][n];
      }
      tBuf[nb].count = 0;
      ++ countCorrAv;
      if (countCorrAv == limitCorrAv) {
        for (j = 0; j < 3 * nFunCorr; j ++) {
          for (n = 0; n < nValCorr; n ++)
             avAcfST[j][n] /= 3. * nMol * limitCorrAv;
        }
        PrintSpacetimeCorr (stdout);
        ZeroSpacetimeCorr ();
      }
    }
  }
}
