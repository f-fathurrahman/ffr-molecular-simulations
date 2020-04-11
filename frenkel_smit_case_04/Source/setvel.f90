SUBROUTINE SETVEL(Temp, Iseed, Vx0t, Vy0t, Vz0t)
!
!   Give particles an random initial velocity
!
!   Temp (input)  : requested temperature
!   Iseed (input) : seed random number generator
!                   (not used in present implementation)
!   Vx0t (output) : x component veloocity center of mass
!   Vy0t (output) : y component veloocity center of mass
!   Vz0t (output) : z component veloocity center of mass
!
  USE m_globals
  IMPLICIT NONE
  INTEGER :: i, Iseed
  REAL(8) :: v2, vx0, vy0, vz0, Vx0t, Vy0t, Vz0t, Temp, RANF, f
 
! ===give particle a velocity
! ===velocity
  vx0 = 0.D0
  vy0 = 0.D0
  vz0 = 0.D0
  v2 = 0.D0
  DO i = 1, NPART
     VX(i) = RANF(Iseed) - 0.5D0
     VY(i) = RANF(Iseed) - 0.5D0
     VZ(i) = RANF(Iseed) - 0.5D0
     vx0 = vx0 + VX(i)
     vy0 = vy0 + VY(i)
     vz0 = vz0 + VZ(i)
     v2 = v2 + VX(i)**2 + VY(i)**2 + VZ(i)**2
  ENDDO

  !  ===set centre of mass movement to zero
  vx0 = vx0/NPART
  vy0 = vy0/NPART
  vz0 = vz0/NPART
  Vx0t = 0.D0
  Vy0t = 0.D0
  Vz0t = 0.D0
  f = SQRT(3*NPART*Temp/v2)
  v2 = 0.D0
  DO i = 1, NPART
    VX(i) = (VX(i)-vx0)*f
    VY(i) = (VY(i)-vy0)*f
    VZ(i) = (VZ(i)-vz0)*f
    Vx0t = Vx0t + VX(i)
    Vy0t = Vy0t + VY(i)
    Vz0t = Vz0t + VZ(i)
    v2 = v2 + VX(i)**2 + VY(i)**2 + VZ(i)**2
  ENDDO
  v2 = v2/DBLE(3*NPART)
  Vx0t = Vx0t/NPART
  Vy0t = Vy0t/NPART
  Vz0t = Vz0t/NPART
  Temp = v2
  WRITE(*, 99001) v2
  WRITE(*, 99002) Vx0t, Vy0t, Vz0t
  
  RETURN

99001 FORMAT (' Initial temperature     : ', f5.3)

99002 FORMAT (' Velocity centre of mass : ', /, '          x = ', e8.2, &
              /, '          y = ', e8.2, /, '          z = ', e8.2)

END
