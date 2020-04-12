SUBROUTINE RANTEST(Iseed)
! test and initialize the random number generator
  IMPLICIT NONE
  INTEGER :: Iseed, i
  REAL(8) :: RANF
 
  CALL RANSET(Iseed)
  WRITE(*,*) ' ******** test random numbers ***********'
  DO i = 1, 5
    WRITE(*,*) 'i, ranf() ', i, RANF(Iseed)
  END DO
  RETURN
END SUBROUTINE
