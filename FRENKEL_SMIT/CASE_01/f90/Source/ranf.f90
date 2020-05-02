FUNCTION RANF(Idum)
  ! random number generator
  !
  ! Idum (input): can be used as seed (not used in present
  !               random number generator.
  IMPLICIT NONE
  INTEGER :: Idum
  REAL(8) :: RANF, RCARRY
  RANF = RCARRY()
  RETURN
END

FUNCTION RANDX(Iseed)
  !----------------------------------------------------------------------C
  !  Random number generator, fast and rough, machine independent.
  !  Returns an uniformly distributed deviate in the 0 to 1 interval.
  !  This random number generator is portable, machine-independent and
  !  reproducible, for any machine with at least 32 bits / real number.
  !  REF: Press, Flannery, Teukolsky, Vetterling, Numerical Recipes (1986)
  !----------------------------------------------------------------------C
  IMPLICIT NONE
  INTEGER :: IA, IC, Iseed, M1
  REAL(8) :: RANDX, RM
  PARAMETER (M1=714025, IA=1366, IC=150889, RM=1.D+0/M1)

  Iseed = MOD(IA*Iseed+IC, M1)
  RANDX = Iseed*RM
  IF( RANDX < 0.D+0 ) THEN
    STOP '*** Random number is negative ***'
  END IF
  RETURN
END FUNCTION

 
SUBROUTINE RANSET(Iseed)
! initializes random number generator
  IMPLICIT NONE
  INTEGER Iseed
  CALL RSTART(Iseed)
  RETURN
END SUBROUTINE
 
SUBROUTINE RSTART(Iseeda)
  !----------------------------------------------------------------------C
  !       Initialize Marsaglia list of 24 random numbers.
  !----------------------------------------------------------------------C
  IMPLICIT NONE
  REAL(8) :: CARRY, ran, RANDX, SEED
  INTEGER :: i, I24, ISEED, Iseeda, J24
  COMMON /RANDOM/ SEED(24), CARRY, I24, J24, ISEED
 
  I24 = 24
  J24 = 10
  CARRY = 0.D+0
  ISEED = Iseeda
  
  ! get rid of initial correlations in rand by throwing
  ! away the first 100 random numbers generated.
  DO i = 1, 100
    ran = RANDX(ISEED)
  END DO
  
  ! initialize the 24 elements of seed 
  DO i = 1, 24
    SEED(i) = RANDX(ISEED)
  END DO

  RETURN
END SUBROUTINE
 
FUNCTION RCARRY()
!----------------------------------------------------------------------
! Random number generator from Marsaglia.
!----------------------------------------------------------------------
  IMPLICIT NONE
  REAL(8) :: CARRY, RCARRY, SEED, uni
  INTEGER :: I24, ISEED, J24
  REAL(8), PARAMETER :: TWOp24=16777216.D+0
  REAL(8), PARAMETER :: TWOm24=1.D+0/TWOp24
  COMMON /RANDOM/ SEED(24), CARRY, I24, J24, ISEED
  
  ! F. James Comp. Phys. Comm. 60, 329  (1990)
  ! algorithm by G. Marsaglia and A. Zaman
  ! base b = 2**24  lags r=24 and s=10
  uni = SEED(I24) - SEED(J24) - CARRY
  
  IF (uni.LT.0.D+0) THEN
     uni = uni + 1.D+0
     CARRY = TWOm24
  ELSE
     CARRY = 0.D+0
  END IF
  
  SEED(I24) = uni
  
  I24 = I24 - 1
  IF (I24.EQ.0) I24 = 24
  
  J24 = J24 - 1
  IF (J24.EQ.0) J24 = 24
  
  RCARRY = uni
 
  RETURN
END FUNCTION
