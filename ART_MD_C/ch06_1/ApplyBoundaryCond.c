#undef VWrap

#define VWrap(v, t)                                         \
   if (v.t >= 0.5) v.t -= 1.;                               \
   else if (v.t < -0.5) v.t += 1.

void ApplyBoundaryCond ()
{
  int n;

  DO_MOL VWrapAll (mol[n].r);
}
