SUBROUTINE RANTEST(Iseed)
! test and initialize the random number generator
  IMPLICIT NONE
  INTEGER :: Iseed, i
  REAL(8) :: RANF
 
  CALL RANSET(Iseed)

  WRITE(*,*)
  WRITE(*,*) 'Initializing and testing random number'
  WRITE(*,*)

  DO i = 1, 5
    WRITE(*,'(1x,A,I2,A,F18.10)') 'i = ', i, ' ranf() = ', RANF(Iseed)
  END DO
  RETURN
END SUBROUTINE
