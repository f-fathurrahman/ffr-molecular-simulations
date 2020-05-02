SUBROUTINE TOTERG(Ener, Vir, Enk)
!
!     calculates total energy
!
!  Ener (output) : total (potential + kinetic) energy
!  Vir  (output) : total virial
!  Enk  (ouput)  : total kinetic energy
!
  USE m_globals
  IMPLICIT NONE
 
  REAL(8) :: xi, yi, zi, Ener, eni, viri, Vir, Enk
  INTEGER :: i, jb
 
  Ener = 0
  Vir = 0
  Enk = 0
  DO i = 1, NPART
    xi = X(i)
    yi = Y(i)
    zi = Z(i)
    jb = i + 1
    CALL ENERI(xi, yi, zi, i, jb, eni, viri)
    Ener = Ener + eni
    Vir = Vir + viri
    Enk = Enk + (VX(i)*VX(i)+VY(i)*VY(i)+VZ(i)*VZ(i))
  END DO
  
  ! kinetic energy
  Enk = 0.5D0*Enk
  Ener = Ener + Enk
  RETURN
END SUBROUTINE
