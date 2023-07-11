void InitCoords ()
{
  VecR c, gap;
  int n, nx, ny;

  VDiv (gap, region, initUcell);
  n = 0;
  for (ny = 0; ny < initUcell.y; ny ++) {
    for (nx = 0; nx < initUcell.x; nx ++) {
      VSet (c, nx + 0.5, ny + 0.5);
      VMul (c, c, gap);
      VVSAdd (c, -0.5, region);
      mol[n].r = c;
      ++ n;
    }
  }
}
