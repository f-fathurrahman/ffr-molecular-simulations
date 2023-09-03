void EvalVacf ()
{
  VecR vecTherm, vecVisc;
  int n, nb, ni;

  VZero (vecVisc);
  VZero (vecTherm);
  DO_MOL {
    vecVisc.x += mol[n].rv.y * mol[n].rv.z + 0.5 * mol[n].rf[1].z;
    vecVisc.y += mol[n].rv.z * mol[n].rv.x + 0.5 * mol[n].rf[2].x;
    vecVisc.z += mol[n].rv.x * mol[n].rv.y + 0.5 * mol[n].rf[0].y;
    mol[n].en += VLenSq (mol[n].rv);
    VVSAdd (vecTherm, 0.5 * mol[n].en, mol[n].rv);
    vecTherm.x += 0.5 * VDot(mol[n].rv, mol[n].rf[0]);
    vecTherm.y += 0.5 * VDot(mol[n].rv, mol[n].rf[1]);
    vecTherm.z += 0.5 * VDot(mol[n].rv, mol[n].rf[2]);
  }
  for (nb = 0; nb < nBuffAcf; nb ++) {
    if (tBuf[nb].count == 0) {
      DO_MOL tBuf[nb].orgVel[n] = mol[n].rv;
    }
    if (tBuf[nb].count >= 0) {
      ni = tBuf[nb].count;
      tBuf[nb].acfVel[ni] = 0.;
      DO_MOL tBuf[nb].acfVel[ni] += VDot (tBuf[nb].orgVel[n], mol[n].rv);
    }
    if (tBuf[nb].count == 0) {
      tBuf[nb].orgVisc = vecVisc;
      tBuf[nb].orgTherm = vecTherm;
    }
    tBuf[nb].acfVisc[ni] = VDot (tBuf[nb].orgVisc, vecVisc);
    tBuf[nb].acfTherm[ni] = VDot (tBuf[nb].orgTherm, vecTherm);
    ++ tBuf[nb].count;
  }
  AccumVacf ();
}
