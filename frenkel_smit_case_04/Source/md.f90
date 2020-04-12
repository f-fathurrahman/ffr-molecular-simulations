PROGRAM MD
  USE m_globals, ONLY: npmax, samp1, nsamp

  IMPLICIT NONE
  INTEGER :: nstep, nstep10, step
  LOGICAL :: scale
  REAL(8) :: en, ent, vir, virt, enk, time, enpot, delt, tmax, &
                     enkt, tequil, temprsq

  REAL(8) :: fx(NPMax), fy(NPMax), fz(NPMax)
 
  WRITE(*,*)
  WRITE(*,*) 'Molecular Dynamics starting ...'
  WRITE(*,*) '________________________________________________________________________'
  WRITE(*,*) ''
  WRITE(*,*) '   Understanding Molecular Simulations: From Algorithms to Applications'
  WRITE(*,*) '   Case Study 4:  Static properties of the Lennard-Jones fluid'
  WRITE(*,*) '_________________________________________________________________________'


  ! initialize system
  CALL INIT(delt, tmax, tequil, temprsq, scale)

  ! total energy of the system
  CALL TOTERG(en, vir, enk)

  WRITE(*, 99001) en - enk, enk, en + enk, vir
  
  step = 0
  time = 0
  
  IF (SAMP1) CALL SAMPLE(0, step, en, vir, enk, delt)
  !      IF (SAMP2) CALL SAMPLE2(0, delt)

  nstep = INT(tmax/delt)
  nstep10 = INT(nstep/10)
  
  IF (nstep.EQ.0) nstep10 = 0
  
  DO WHILE (time.LT.tmax)
    
    CALL FORCE(fx, fy, fz, enpot, vir)
    CALL SOLVE(fx, fy, fz, enk, delt)
    
    time = time + delt
    en = enpot + enk
    step = step + 1
    
    IF( time < tequil ) THEN
      IF( scale ) THEN
        IF( MOD(step,20) == 0) CALL VELOCS(temprsq)
      ENDIF
    ! if system equilbrated sample averages:
    ELSEIF (MOD(step,NSAMP) == 0) THEN
      IF (SAMP1) CALL SAMPLE(1, step, en, vir, enk, delt)
      ! IF (SAMP2) CALL SAMPLE2(1, delt)
    ENDIF
    
    IF (MOD(step,nstep10) == 0) THEN
      WRITE(*, '(1x,A,F18.10,A,F18.10,F18.10)') '======>> Done ', time, ' out of ', tmax, en
      ! write intermediate configuration to file
      CALL STORE(8)
    ENDIF
  
  ENDDO

  CALL TOTERG(ent, virt, enkt)
  
  IF (SAMP1) CALL SAMPLE(2, step, en, vir, enk, delt)
  !IF (SAMP2) CALL SAMPLE2(2, delt)
  
  WRITE (6, 99002) ent, virt
  
  CALL STORE(21)
  
  STOP
! 
99001 FORMAT (' Total pot. energy in. conf.       : ', f12.5, /, &
              ' Total kinetic energy in. conf.    : ', f12.5, /, &
              ' Total energy in. conf.            : ', f12.5, /, &
              ' Total virial initial configuration: ', f12.5)

99002 FORMAT (' Total energy end of simulation    : ', f12.5, /, &
              ' Total virial end of simulation    : ', f12.5)
 
END
