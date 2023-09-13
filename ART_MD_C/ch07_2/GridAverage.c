void GridAverage (int opCode)
{
  VecR invWid, rs, va;
  VecI cc;
  real pSum;
  int c, hSize, j, n;

  hSize = VProd (sizeHistGrid);
  if (opCode == 0) {
    for (j = 0; j < NHIST; j ++) {
      for (n = 0; n < hSize; n ++) histGrid[j][n] = 0.;
    }
  } else if (opCode == 1) {
    VDiv (invWid, sizeHistGrid, region);
    DO_MOL {
      VSAdd (rs, mol[n].r, 0.5, region);
      VMul (cc, rs, invWid);
      c = VLinear (cc, sizeHistGrid);
      ++ histGrid[0][c];
      histGrid[1][c] += VLenSq (mol[n].rv);
      histGrid[2][c] += mol[n].rv.x;
      histGrid[3][c] += mol[n].rv.y;
      histGrid[4][c] += mol[n].rv.z;
    }
  } else if (opCode == 2) {
    pSum = 0.;
    for (n = 0; n < hSize; n ++) {
      if (histGrid[0][n] > 0.) {
        for (j = 1; j < NHIST; j ++)
           histGrid[j][n] /= histGrid[0][n];
        VSet (va, histGrid[2][n], histGrid[3][n], histGrid[4][n]);
        histGrid[1][n] = (histGrid[1][n] - VLenSq (va)) / NDIM;
        pSum += histGrid[0][n];
      }
    }
    pSum /= hSize;
    for (n = 0; n < hSize; n ++) histGrid[0][n] /= pSum;
  }
}