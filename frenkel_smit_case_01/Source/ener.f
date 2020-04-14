**==ener.spg  processed by SPAG 4.52O  at 18:54 on 27 Mar 1996
      SUBROUTINE ENER(En, Vir, R2)
c
c     calculate energy
c
c     En : (output) energy
c     Vir: (output) virial
c     R2 : (input) distance squared between two particles
c
      IMPLICIT NONE
      DOUBLE PRECISION R2, r2i, r6i, En, Vir
      INCLUDE 'potential.inc'
 
      IF (R2.LT.RC2) THEN
         r2i = SIG2/R2
         r6i = r2i*r2i*r2i
         IF (SHIFT) THEN
            En = EPS4*(r6i*r6i-r6i) - ECUT
         ELSE
            En = EPS4*(r6i*r6i-r6i)
         END IF
         Vir = EPS48*(r6i*r6i-0.5D0*r6i)
      ELSE
         En = 0
         Vir = 0
      END IF
      RETURN
      END
