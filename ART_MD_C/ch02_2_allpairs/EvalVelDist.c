void EvalVelDist ()
{
  real deltaV, histSum;
  int j, n;

  if( countVel == 0 ) {
    for (j = 0; j < sizeHistVel; j ++) histVel[j] = 0.;
  }
  deltaV = rangeVel / sizeHistVel;
  //printf("deltaV = %f\n", deltaV);

  DO_MOL {
    j = VLen(mol[n].rv) / deltaV;
    ++ histVel[Min(j, sizeHistVel - 1)];
  }
  ++countVel;
  if( countVel == limitVel ) {
    printf("countVel = %d, limitVel = %d\n", countVel, limitVel);
    histSum = 0.;
    for(j = 0; j < sizeHistVel; j ++) {
      histSum += histVel[j];
    }
    printf("hist_sum = %18.10f\n", histSum);
    for(j = 0; j < sizeHistVel; j ++) {
      histVel[j] /= histSum;
    }

    histSum = 0.0;
    for(j = 0; j < sizeHistVel; j ++) {
      histSum += histVel[j];
    }
    printf("hist_sum after normalization = %18.10f\n", histSum);

    hFunction = 0.0;
    for(j = 0; j < sizeHistVel; j ++) {
      if( histVel[j] > 0.0) {
        hFunction += histVel[j] * log(histVel[j] / ((j + 0.5) * deltaV));
      }
    }
    printf("sim.hFunction = %18.10f\n", hFunction);
    PrintVelDist2(veldist_file, hfunc_file);
    countVel = 0;
  }
}
