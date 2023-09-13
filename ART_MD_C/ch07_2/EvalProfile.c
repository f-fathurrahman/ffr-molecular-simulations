void EvalProfile ()
{
  int k, n;

  for (n = 0; n < sizeHistGrid.z; n ++) {
    profileT[n] = 0.;
  }
  for (n = 0; n < VProd (sizeHistGrid); n ++) {
    k = n / (sizeHistGrid.x * sizeHistGrid.y);
    profileT[k] += histGrid[1][n];
  }
  for (n = 0; n < sizeHistGrid.z; n ++) {
    profileT[n] /= sizeHistGrid.x * sizeHistGrid.y;
  }
}