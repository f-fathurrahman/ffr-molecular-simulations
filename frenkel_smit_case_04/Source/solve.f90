SUBROUTINE SOLVE(Fx, Fy, Fz, Enkin, Delt)
!
!   Solve the equations of motion
!
!  Fx    (input) array: x component of the force acting on the particles
!  Fy    (input) array: y component of the force acting on the particles
!  Fz    (input) array: z component of the force acting on the particles
!  Enkin (ouput)      : total kinetic energy
!  Delt  (input)      : time step MD simulation
!
  USE m_globals
  IMPLICIT NONE
  REAL(8) :: Fx(npmax), Fy(npmax), Fz(npmax)
  REAL(8) :: v2, vxt, vyt, vzt, Enkin, Delt
  INTEGER :: i
 
  v2 = 0.D0
  
  ! ===solve equations of motion
  DO i = 1, NPART
    ! ===leap frog alogithm
    vxt = VX(i)
    vyt = VY(i)
    vzt = VZ(i)
    VX(i) = VX(i) + Delt*Fx(i)
    VY(i) = VY(i) + Delt*Fy(i)
    VZ(i) = VZ(i) + Delt*Fz(i)
    X(i) = X(i) + Delt*VX(i)
    Y(i) = Y(i) + Delt*VY(i)
    Z(i) = Z(i) + Delt*VZ(i)
    v2 = v2 + (VX(i)+vxt)**2/4 + (VY(i)+vyt)**2/4 + (VZ(i)+vzt)**2/4
  ENDDO
  Enkin = v2/2
  RETURN

END SUBROUTINE
