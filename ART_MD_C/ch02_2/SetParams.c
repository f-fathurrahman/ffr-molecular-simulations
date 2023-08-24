void SetParams ()
{

  printf("---------------\n");
  printf("Enter SetParams\n");
  printf("---------------\n");

  rCut = pow (2., 1./6.);
  
  VSCopy(region, 1. / sqrt (density), initUcell);
  
  nMol = VProd (initUcell);
  
  velMag = sqrt (NDIM * (1. - 1. / nMol) * temperature);
  
  VSCopy(cells, 1. / (rCut + rNebrShell), region);
  printf("cells.x = %d\n", cells.x);
  printf("cells.y = %d\n", cells.y);

  nebrTabMax = nebrTabFac * nMol;
  printf("nebrTabMax = %d\n", nebrTabFac);


  printf("---------------\n");
  printf("Enter SetParams\n");
  printf("---------------\n");


}
