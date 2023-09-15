void SetParams ()
{
  rCut = pow (2., 1./6.);
  printf("rCut = %f\n", rCut);

  VSCopy(region, 1. / pow (density, 1./3.), initUcell);
  printf("region = [%f,%f,%f]\n", region.x, region.y, region.z);
  
  nMol = VProd(initUcell);
  printf("nMol = %d\n", nMol);

  velMag = sqrt(NDIM * (1. - 1. / nMol) * temperature);
  printf("velMag = %f\n", velMag);

  VSCopy(cells, 1. / rCut, region);
  printf("cells = [%d,%d,%d]\n", cells.x, cells.y, cells.x);
}
