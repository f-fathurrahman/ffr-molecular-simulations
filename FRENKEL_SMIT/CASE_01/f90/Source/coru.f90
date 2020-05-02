FUNCTION CORU(R, Rho)
!
!     tail correction for the energy:
!
!  CORU (output) energy tail correction
!  R    (input)  cutoff radius
!  Rho  (input)  density
!
  use m_globals, ONLY: sig2, pi, eps4
  IMPLICIT NONE
  REAL(8) :: sig3, ri3, R, CORU, Rho
 
  sig3 = SIG2*SQRT(SIG2)
  ri3 = sig3/(R*R*R)
  
  CORU = 2*PI*EPS4*(Rho*sig3)*(ri3*ri3*ri3/9-ri3/3)
  
  RETURN
END FUNCTION
