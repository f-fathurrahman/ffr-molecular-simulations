PROGRAM MC_NVT
!________________________________________________________________________
!
!   Understanding Molecular Simulations: From Algorithms to Applications
!
!                 Daan Frenkel  and  Berend Smit
!
!   Case Study 1: Equation of state of the Lennard-Jones fluid
!__________________________________________________________________________
 
  IMPLICIT NONE
  INTEGER :: iseed, equil, prod, nsamp, ii, icycl, ndispl, attempt, &
         nacc, ncycl, nmoves, imove
  REAL(8) :: en, ent, vir, virt, dr
 
  WRITE(*,*)
  WRITE(*,*) 'Monte Carlo program starts'
  WRITE(*,*)
  
  ! initialize sysem
  CALL READDAT(equil, prod, nsamp, ndispl, dr, iseed)
  nmoves = ndispl
  
  ! total energy of the system
  CALL TOTERG(en, vir)

  WRITE(*,'(1x,A,F18.10)') 'Total energy of initial configuration:', en
  WRITE(*,'(1x,A,F18.10)') 'Total virial of initial configuration:', vir
  
  ! start MC-cycle
  DO ii = 1, 2
    ! ii=1 equilibration
    ! ii=2 production
    IF( ii == 1 ) THEN
      ncycl = equil
      IF( ncycl /= 0 ) WRITE(*,*) ' Start equilibration '
    ELSE
      IF( ncycl /= 0 ) WRITE(*,*) ' Start production '
      ncycl = prod
    ENDIF
    
    attempt = 0
    nacc = 0
    
    ! intialize the subroutine that adjust the maximum displacement
    CALL ADJUST(attempt, nacc, dr)
    
    DO icycl = 1, ncycl
      !
      DO imove = 1, nmoves
        ! attempt to displace a particle
        CALL MCMOVE(en, vir, attempt, nacc, dr, iseed)
      ENDDO
      
      IF( ii == 2 ) THEN
        ! sample averages
        IF( MOD(icycl,nsamp) == 0 ) CALL SAMPLE(icycl, en, vir)
      ENDIF
      
      IF( MOD(icycl,ncycl/5) == 0 ) THEN
        WRITE(*,'(1x,A,I8,A,I8)') 'Done ', icycl, ' cycles out of ', ncycl
        ! write intermediate configuration to file
        CALL STORE(8, dr)
        ! adjust maximum displacements
        CALL ADJUST(attempt, nacc, dr)
      ENDIF
    ENDDO
    
    IF( ncycl /= 0 ) THEN
      !
      IF( attempt /= 0 ) WRITE(*, 99003) attempt, nacc, 100.d0*dble(nacc)/dble(attempt)
      ! test total energy
      CALL TOTERG(ent, virt)
      !
      IF( ABS(ent-en) > 1.D-6 ) THEN
        WRITE(*,*) 'PROBLEMS ENERGY'
      ENDIF
      !
      IF( ABS(virt-vir) > 1.D-6) THEN
        WRITE(*,*) 'PROBLEMS VIRIAL'
      ENDIF
      !
      WRITE(*,*)
      WRITE(*,'(1x,A,F18.10)') 'Total energy at the end of simulation : ', ent
      WRITE(*,'(1x,A,F18.10)') 'Running energy                        : ', en
      WRITE(*,'(1x,A,E18.10)') 'Difference                            : ', ent - en
      WRITE(*,*)
      WRITE(*,'(1x,A,F18.10)') 'Total virial at the end of simulation : ', virt
      WRITE(*,'(1x,A,F18.10)') 'Running virial                        : ', vir
      WRITE(*,'(1x,A,E18.10)') 'Difference                            : ', virt - vir
    ENDIF
  END DO
  
  CALL STORE(21, dr)
  
  STOP

99003 FORMAT (' Number of att. to displ. a part.  : ', i10, /, &
              ' success: ', i10, '(= ', f5.2, '%)')

END PROGRAM
