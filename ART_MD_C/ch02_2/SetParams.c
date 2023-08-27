void SetParams ()
{

  printf("---------------\n");
  printf("ENTER SetParams\n");
  printf("---------------\n");

  rCut = pow(2.0, 1.0/6.0);
  printf("rCut = %f\n", rCut);

  VSCopy(region, 1.0 / sqrt(density), initUcell);
  printf("region = [%f,%f]\n", region.x, region.y);

  nMol = VProd(initUcell);
  printf("nMol = %d\n", nMol);

  velMag = sqrt(NDIM * (1.0 - 1.0/nMol) * temperature);
  
  VSCopy(cells, 1.0 / (rCut + rNebrShell), region);
  printf("cells.x = %d\n", cells.x);
  printf("cells.y = %d\n", cells.y);

  nebrTabMax = nebrTabFac * nMol;
  printf("nebrTabMax = %d\n", nebrTabFac);


  printf("---------------\n");
  printf("EXIT SetParams\n");
  printf("---------------\n");


}
