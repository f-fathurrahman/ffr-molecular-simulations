SUBROUTINE calc_total_energy(Ener, Vir)
!
!     calculates total energy
!
!  Ener (output) : total energy
!  Vir  (output) : total virial
!
  USE m_globals, ONLY: x, y, z, tailco, npart, box, rc
  IMPLICIT NONE
  !
  ! arguments
  real(8) :: ener, vir
  !
  ! local variables
  REAL(8) :: xi, yi, zi, eni, CORU, viri, rho
  INTEGER :: i, jb
 
  Ener = 0.d0
  Vir = 0.d0
  DO i = 1, NPART - 1
    xi = X(i)
    yi = Y(i)
    zi = Z(i)
    jb = i + 1
    CALL calc_ener_i(xi, yi, zi, i, jb, eni, viri)
    Ener = Ener + eni
    Vir = Vir + viri
  END DO
  
  ! add tail corrections
  IF( TAILCO ) THEN
    rho = NPART/(BOX**3)
    Ener = Ener + NPART*CORU(RC, rho)
  ENDIF
  
  RETURN
END SUBROUTINE
 
