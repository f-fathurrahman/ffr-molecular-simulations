SUBROUTINE READDAT(Equil, Prod, Nsamp, Ndispl, Dr, Iseed)
!     ---read input data and model parameters
!
!     ---input parameters: file: fort.15
!    ibeg  =  0 : initialize from a lattice
!             1 : read configuration from disk
!    Equil      : number of Monte Carlo cycles during equilibration
!    Prod       : number of Monte Carlo cycles during production
!    Nsamp      : number of Monte Carlo cycles between two sampling periods
!    Iseed      : seed random number generator
!    Dr         : maximum displacement
!    Ndispl     : number of attemps to displace a particle per MC cycle
!    NPART      : total numbero fo particles
!    TEMP       : temperature
!    rho        : density
!
!     ---input parameters: file: fort.25
!    TAILCO = .true. : tail corrections are applied
!             .false.: no-tail corrections
!    SHIFT  = .true. : potential is shifted
!             .false.: potential is NOT-shifted
!    eps    = epsilon Lennard-Jones potential
!    sig    = sigma Lennard-Jones potential
!    MASS   = mass of the particle
!    RC     = cut-off radius of the potential
!
!     ---input parameters: file: fort.11 (restart file
!                to continue a simulation from disk)
!    boxf   = Box length old configuration (if this one
!             does not correspond to the requested density, the positions
!             of the particles are rescaled!
!    NPART  = number of particles (over rules fort.15!!)
!    Dr     = optimized maximum displacement old configurations
!    X(1),Y(1),Z(1)            : position first particle 1
!        ...
!    X(NPART),Y(NPART),Z(NPART): position particle last particle
 
  USE m_globals, ONLY: x, y, z, box, hbox, temp, tailco, sig2, shift, rc2, rc, npmax, &
                       npart, mass, ecut, eps4, eps48, beta

  IMPLICIT NONE

  INTEGER :: ibeg, Equil, Prod, i, Ndispl, Nsamp, Iseed
  REAL(8) :: eps, sig, CORU, CORP, vir, boxf, rhof, rho, Dr
 
  ! read simulation data
  READ(15, *)
  READ(15, *) ibeg, Equil, Prod, Nsamp, Iseed
  READ(15, *)
  READ(15, *) Dr
  READ(15, *)
  READ(15, *) Ndispl
  READ(15, *)
  READ(15, *) NPART, TEMP, rho
  
  ! initialise and test random number generator
  CALL RANTEST(Iseed)
 
  IF (NPART > NPMax) THEN
    WRITE(*, *) ' ERROR: number of particles too large'
    STOP
  END IF
  BOX = (NPART/rho)**(1.D0/3.D0)
  HBOX = BOX/2
  
  ! read model parameters
  READ(25, *)
  READ(25, *) TAILCO, SHIFT
  READ(25, *)
  READ(25, *) eps, sig, MASS, RC
  
  ! read/generate configuration
  IF (ibeg.EQ.0) THEN
    ! generate configuration form lattice
    CALL LATTICE()
  ELSE
    WRITE(*, *) ' read conf from disk '
    READ(11, *) boxf
    READ(11, *) NPART
    READ(11, *) Dr
    rhof = NPART/boxf**3
    IF( ABS(boxf-BOX) > 1D-6 ) THEN
      WRITE(6, 99007) rho, rhof
    ENDIF
    DO i = 1, NPART
      READ (11, *) X(i), Y(i), Z(i)
      X(i) = X(i)*BOX/boxf
      Y(i) = Y(i)*BOX/boxf
      Z(i) = Z(i)*BOX/boxf
    END DO
    REWIND (11)
  ENDIF

  ! write input data
  WRITE(*, 99001) Equil, Prod, Nsamp
  WRITE(*, 99002) Ndispl, Dr
  WRITE(*, 99003) NPART, TEMP, rho, BOX
  WRITE(*, 99004) eps, sig, MASS
  
  ! calculate parameters:
  BETA = 1/TEMP
  ! calculate cut-off radius potential
  RC = MIN(RC, HBOX)
  RC2 = RC*RC
  EPS4 = 4*eps
  EPS48 = 48*eps
  SIG2 = sig*sig
  
  IF( SHIFT ) THEN
    ! calculate energy of the shift
    ECUT = 0
    CALL ENER(ECUT, vir, RC2)
    WRITE(*, 99005) RC, ECUT
  END IF

  IF( TAILCO ) THEN
    WRITE(*, 99006) RC, CORU(RC, rho), CORP(RC, rho)
  END IF
  
  RETURN

99001 FORMAT ('  Number of equilibration cycles             :', i10, /, &
              '  Number of production cycles                :', i10, /, &
              '  Sample frequency                           :',i10, /)

99002 FORMAT ('  Number of att. to displ. a part. per cycle :', i10, /, &
              '  Maximum displacement                       :', f10.3, &
              //)

99003 FORMAT ('  Number of particles                        :', i10, /, &
              '  Temperature                                :', f10.3, &
              /, '  Density                                    :', &
              f10.3, /, '  Box length                                 :' &
              , f10.3, /)

99004 FORMAT ('  Model parameters: ', /, '     epsilon: ', f5.3, /, &
              '     sigma  : ', f5.3, /, '     mass   : ', f5.3)

99005 FORMAT (' Simulations with TRUNCATED AND SHIFTED potential: ', /, &
              ' Potential truncated at :', f10.3, /, &
              ' Energy shif            :', f10.3, //)

99006 FORMAT (' Simulations with tail correction: ', /, &
              ' Potential truncated at  Rc =:', f10.3, /,& 
              ' Tail corrections:   energy = ', f10.3, ' pressure ', &
              f10.3, /, /)

99007 FORMAT (' Requested density: ', f5.2, &
              ' different from density on disk: ', f5.2, /, &
              ' Rescaling of coordinates!')

END SUBROUTINE
