void AdjustPressure ()
{
  real rFac, w;
  int maxPressCycle, n;

  maxPressCycle = 20;
  if (fabs (pressure.val - extPressure) > tolPressure * extPressure) {
    UnscaleCoords ();
    vvSum = vvSum / Sqr (varL);
    for (nPressCycle = 0; nPressCycle < maxPressCycle; nPressCycle ++) {
      UpdateCellSize ();
      ComputeForces ();
      w = 3. * Cube (varL);
      pressure.val = (vvSum * Sqr (varL) + virSum) / w;
      rFac = 1. + (pressure.val - extPressure) /
         (3. * pressure.val + dvirSum2 / w);
      DO_MOL VScale (mol[n].r, rFac);
      VScale (region, rFac);
      varL *= rFac;
      if (fabs (pressure.val - extPressure) <
         tolPressure * extPressure) break;
    }
    ScaleCoords ();
    vvSum *= Sqr (varL);
  }
}