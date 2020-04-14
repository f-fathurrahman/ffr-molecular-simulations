SUBROUTINE STORE(Iout, Dr)
!
!     writes configuration to disk
!
!  Iout (input) file number
!  Dr   (input) maximum displacement
!
!
  USE m_globals, ONLY: x, y, z, box, hbox, npart
  IMPLICIT NONE
  INTEGER :: Iout, i
  REAL(8) :: Dr
 
  WRITE(Iout, *) BOX, HBOX
  WRITE(Iout, *) NPART
  WRITE(Iout, *) Dr
  
  DO i = 1, NPART
    WRITE(Iout, *) X(i), Y(i), Z(i)
  ENDDO
  
  REWIND (Iout)
  
  RETURN
END SUBROUTINE
