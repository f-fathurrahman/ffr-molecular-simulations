FUNCTION CORP(R, Rho)
!
!     tail correction for the pressure:
!
!  CORP (output) tail correction pressure
!  R    (input)  cutoff radius
!  Rho  (input)  density
!
  USE m_globals, ONLY: sig2, pi, eps4
  IMPLICIT NONE
  REAL(8) :: sig3, ri3, R, CORP, Rho
 
  sig3 = SIG2*SQRT(SIG2)
  ri3 = sig3/(R*R*R)
  CORP = 4*PI*EPS4*(Rho**2)*sig3*(2*ri3*ri3*ri3/9-ri3/3)
  
  RETURN

END FUNCTION
