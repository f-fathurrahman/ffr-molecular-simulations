void EvalSpacetimeCorr ()
{
  real b, c, c0, c1, c2, kVal, s, s1, s2, w;
  int j, k, m, n, nb, nc, nv;

  for (j = 0; j < 24 * nFunCorr; j ++) valST[j] = 0.;
  kVal = 2. * M_PI / region.x;
  DO_MOL {
    j = 0;
    for (k = 0; k < 3; k ++) {
      for (m = 0; m < nFunCorr; m ++) {
        if (m == 0) {
          b = kVal * VComp (mol[n].r, k);
          c = cos (b);
          s = sin (b);
          c0 = c;
        } else if (m == 1) {
          c1 = c;
          s1 = s;
          c = 2. * c0 * c1 - 1.;
          s = 2. * c0 * s1;
        } else {
          c2 = c1;
          s2 = s1;
          c1 = c;
          s1 = s;
          c = 2. * c0 * c1 - c2;
          s = 2. * c0 * s1 - s2;
        }
        valST[j ++] += mol[n].rv.x * c;
        valST[j ++] += mol[n].rv.x * s;
        valST[j ++] += mol[n].rv.y * c;
        valST[j ++] += mol[n].rv.y * s;
        valST[j ++] += mol[n].rv.z * c;
        valST[j ++] += mol[n].rv.z * s;
        valST[j ++] += c;
        valST[j ++] += s;
      }
    }
  }
  for (nb = 0; nb < nBuffCorr; nb ++) {
    if (tBuf[nb].count == 0) {
      for (j = 0; j < 24 * nFunCorr; j ++)
         tBuf[nb].orgST[j] = valST[j];
    }
    if (tBuf[nb].count >= 0) {
      for (j = 0; j < 3 * nFunCorr; j ++)
         tBuf[nb].acfST[j][tBuf[nb].count] = 0.;
      j = 0;
      for (k = 0; k < 3; k ++) {
        for (m = 0; m < nFunCorr; m ++) {
          for (nc = 0; nc < 4; nc ++) {
            nv = 3 * m + 2;
            if (nc < 3) {
              w = Sqr (kVal * (m + 1));
              -- nv;
              if (nc == k) -- nv;
              else w *= 0.5;
            } else w = 1.;
            tBuf[nb].acfST[nv][tBuf[nb].count] +=
               w * (valST[j] * tBuf[nb].orgST[j] +
               valST[j + 1] * tBuf[nb].orgST[j + 1]);
            j += 2;
          }
        }
      }
    }
    ++ tBuf[nb].count;
  }
  AccumSpacetimeCorr ();
}
