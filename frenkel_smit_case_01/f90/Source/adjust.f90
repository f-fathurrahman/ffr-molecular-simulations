SUBROUTINE ADJUST(Attemp, Nacc, Dr)
!
!     adjusts maximum displacement such that 50% of the
!     movels will be accepted
!
!  Attemp (input) number of attemps that have been performed to displace a particle
!  Nacc   (input) number of successful attemps to displace a particle
!  Dr     (output) new maximum displacement
!
  USE m_globals, ONLY: hbox
  IMPLICIT NONE
  INTEGER :: Attemp, Nacc, attempp, naccp
  REAL(8) :: dro, frac, Dr
  SAVE naccp, attempp
 
  IF( (Attemp == 0) .OR. (attempp >= Attemp) ) THEN
    naccp = Nacc
    attempp = Attemp
  ELSE
    frac = DBLE(Nacc-naccp)/DBLE(Attemp-attempp)
    dro = Dr
    Dr = Dr*ABS(frac/0.5D0)
    ! limit the change:
    IF( Dr/dro > 1.5D0 ) Dr = dro*1.5D0
    IF( Dr/dro < 0.5D0 ) Dr = dro*0.5D0
    IF( Dr > HBOX/2.D0 ) Dr = HBOX/2.D0
    WRITE(*, 99001) Dr, dro, frac, Attemp - attempp, Nacc - naccp
    
    ! store nacc and attemp for next use
    naccp = Nacc
    attempp = Attemp
  ENDIF
  
  RETURN

99001 FORMAT (' Max. displ. set to : ', f6.3, ' (old : ', f6.3, ')', /, &
              ' Frac. acc.: ', f4.2, ' attempts: ', i7, ' succes: ', i7)

END SUBROUTINE
