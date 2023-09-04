void UpdateCellSize ()
{
  VSCopy (cells, 1. / rCut, region);
  cells.x = Min (cells.x, maxEdgeCells);
  cells.y = Min (cells.y, maxEdgeCells);
  cells.z = Min (cells.z, maxEdgeCells);
}
