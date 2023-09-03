void EvalDiffusion ()
{
  VecR dr;
  int n, nb, ni;

  for (nb = 0; nb < nBuffDiffuse; nb ++) {
    if (tBuf[nb].count == 0) {
      DO_MOL {
        tBuf[nb].orgR[n] = mol[n].r;
        tBuf[nb].rTrue[n] = mol[n].r;
      }
    }
    if (tBuf[nb].count >= 0) {
      ni = tBuf[nb].count;
      tBuf[nb].rrDiffuse[ni] = 0.;
      DO_MOL {
        VSub (dr, tBuf[nb].rTrue[n], mol[n].r);
        VDiv (dr, dr, region);
        dr.x = Nint (dr.x);
        dr.y = Nint (dr.y);
        dr.z = Nint (dr.z);
        VMul (dr, dr, region);
        VAdd (tBuf[nb].rTrue[n], mol[n].r, dr);
        VSub (dr, tBuf[nb].rTrue[n], tBuf[nb].orgR[n]);
        tBuf[nb].rrDiffuse[ni] += VLenSq (dr);
      }
    }
    ++ tBuf[nb].count;
  }
  AccumDiffusion ();
}
