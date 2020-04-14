SUBROUTINE VELOCS(Temp)
!
!  Simple velocity scaling (only used during equilbration!!!!)
!
!   Temp (input) : target velocity
!
  USE m_globals
  IMPLICIT NONE
 
  REAL(8) :: Temp, v2, f
  INTEGER :: i

  ! --rescale velocities
  v2 = 0
  
  DO i = 1, NPART
    v2 = v2 + VX(i)*VX(i) + VY(i)*VY(i) + VZ(i)*VZ(i)
  ENDDO
  
  v2 = v2/(3*NPART)
  f = SQRT(Temp/v2)
  
  DO i = 1, NPART
    VX(i) = VX(i)*f
    VY(i) = VY(i)*f
    VZ(i) = VZ(i)*f
  ENDDO
  
  RETURN
END SUBROUTINE
