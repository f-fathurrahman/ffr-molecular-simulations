#undef PCR4
#undef PCV4

#define PCR4(r, ro, v, a, a1, a2)                           \
   r = ro + deltaT * v +                                    \
   wr * (cr[0] * a + cr[1] * a1 + cr[2] * a2)
#define PCV4(r, ro, v, a, a1, a2)                           \
   v = (r - ro) / deltaT +                                  \
   wv * (cv[0] * a + cv[1] * a1 + cv[2] * a2)
