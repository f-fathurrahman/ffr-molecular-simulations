function PrintSummary()
  @printf("(%5d,%18.10f) [%18.10f] (%18.10f,%18.10f) (%18.10f,%18.10f) (%18.10f,%18.10f)\n",
     stepCount, timeNow, (vSum.x + vSum.y)/nMol,
     totEnergy.sum, totEnergy.sum2, kinEnergy.sum, kinEnergy.sum2,
     pressure.sum, pressure.sum2 )
end
