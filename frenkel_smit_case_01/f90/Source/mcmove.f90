SUBROUTINE MCMOVE(En, Vir, Attempt, Nacc, Dr, Iseed)
!
!     attempts to displace a randomly selected particle
!
!
!  Ener   (input/output) : total energy
!  Vir    (input/output) : total virial
!  Attemp (input/output) number of attemps that have been
!                  performed to displace a particle
!  Nacc   (input/output) number of successful attemps
!                  to displace a particle
!  Dr     (input) maximum displacement
!  Iseed  (input) seed random number (not used in present
!                  random number generator)
!
  USE m_globals, ONLY: x, y, z, npart, box, beta
  
  IMPLICIT NONE
  REAL(8) :: enn, eno, En, RANF, xn, yn, zn, viro, virn, Vir, Dr
  INTEGER :: o, Attempt, Nacc, jb, Iseed
 
  Attempt = Attempt + 1
  jb = 1
  ! select a particle at random
  o = INT(NPART*RANF(Iseed)) + 1
  
  ! calculate energy old configuration
  CALL ENERI(X(o), Y(o), Z(o), o, jb, eno, viro)
  
  ! give particle a random displacement
  xn = X(o) + (RANF(Iseed)-0.5D0)*Dr
  yn = Y(o) + (RANF(Iseed)-0.5D0)*Dr
  zn = Z(o) + (RANF(Iseed)-0.5D0)*Dr
  
  ! calculate energy new configuration:
  CALL ENERI(xn, yn, zn, o, jb, enn, virn)
  
  ! acceptance test
  IF( RANF(Iseed) < EXP(-BETA*(enn-eno)) ) THEN
    ! accepted
    Nacc = Nacc + 1
    En = En + (enn-eno)
    Vir = Vir + (virn-viro)
    ! put particle in simulation box
    IF( xn  <  0 ) xn = xn + BOX
    IF( xn  >  BOX ) xn = xn - BOX
    !
    IF( yn  <  0 ) yn = yn + BOX
    IF( yn  >  BOX ) yn = yn - BOX
    !
    IF( zn  <  0 ) zn = zn + BOX
    IF( zn  >  BOX ) zn = zn - BOX
    !
    X(o) = xn
    Y(o) = yn
    Z(o) = zn
  ENDIF
  
  RETURN

END SUBROUTINE
