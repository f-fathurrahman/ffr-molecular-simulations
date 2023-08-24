void SetupJob ()
{
  AllocArrays();
  InitRand(randSeed);
  stepCount = 0;
  InitCoords();
  InitVels();
  InitAccels();
  AccumProps(0);
  nebrNow = 1;
  countVel = 0;
}
