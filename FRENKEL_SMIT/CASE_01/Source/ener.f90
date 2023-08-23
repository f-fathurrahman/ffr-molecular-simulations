SUBROUTINE ENER(En, Vir, R2)
!
! calculate energy
!
! En : (output) energy
! Vir: (output) virial
! R2 : (input) distance squared between two particles
  USE m_globals, ONLY: eps4, ecut, eps48, shift, rc2, sig2
  IMPLICIT NONE
  REAL(8) :: R2, r2i, r6i, En, Vir
 
  IF( R2 .LT. RC2 ) THEN
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

END SUBROUTINE
