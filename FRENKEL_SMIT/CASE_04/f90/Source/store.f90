SUBROUTINE STORE(Iout)
!
!     writes configuration to disk
!
!  Iout (input) file number
!
  USE m_globals, ONLY: x, y, z, vx, vy, vz, npart, box, hbox
  IMPLICIT NONE
  INTEGER Iout, i
 
  WRITE(Iout, *) BOX, HBOX
  WRITE(Iout, *) NPART
  DO i = 1, NPART
    WRITE (Iout, *) X(i), Y(i), Z(i), VX(i), VY(i), VZ(i)
  END DO
  REWIND(Iout)
  RETURN

END SUBROUTINE
