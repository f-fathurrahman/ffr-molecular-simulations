 SUBROUTINE SAMPLE(I, En, Vir)
!
!      write quantities (pressure and energy) to file
!
!  Ener (input) : total energy
!  Vir  (input) : total virial

  USE m_globals, ONLY: tailco, rc, npart, beta, box
  IMPLICIT NONE

  INTEGER I
  REAL(8) :: En, enp, Vir, press, CORP, vol, rho
 
  IF( NPART /= 0 ) THEN
    enp = En/DBLE(NPART)
    vol = BOX**3
    press = (NPART/vol)/BETA + Vir/(3*vol)
    rho = NPART/vol
    IF( TAILCO ) press = press + CORP(RC, rho)
  ELSE
    enp = 0
    press = 0
  END IF
  
  WRITE(66, *) I, enp, press
  RETURN

END
