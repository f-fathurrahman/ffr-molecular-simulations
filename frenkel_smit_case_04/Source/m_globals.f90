MODULE m_globals

REAL(8), PARAMETER :: pi=4.d0*atan(1.d0)

! maximum number of particles
INTEGER, PARAMETER :: npmax = 1000

! actual number of particles
INTEGER :: npart

! x(i),y(i),z(i)    : position of particle i
REAL(8) :: x(npmax), y(npmax), z(npmax)

! vx(i),vy(i),vz(i) : velocity particle i
REAL(8) :: vx(npmax), vy(npmax), vz(npmax)

! rc   : cut-off radius of the potenial
! rc2  : rc * rc
! ecut : energy at cut-off radius
REAL(8) :: ecut, rc2

! box      : simulation box length
! hbox     : 0.5 * box
REAL(8) :: box,hbox

! iout1 = output file for radial distribution function
INTEGER :: iout1

! nsamp   = sample frequency: every nsamp timestep the "sample"
!            routines are called
INTEGER :: nsamp

! igr     = (x nsamp) sample frequency radial distribution function;
INTEGER :: igr

! iout2   = output file for velocity autocorrelation function and
!           mean square displacement
INTEGER :: iout2

! it0     = (x nsamp x ntvacf) sample frequency time zero for
!           velocity auto correlation function
INTEGER :: it0

! itstress0 = (x nsamp) sample frequency stress tensor
INTEGER :: itstress0

! iout3   = output file for stress tensor
INTEGER :: iout3

! iout4   = output file for velocity autocorrelation function
!           with error bars
INTEGER :: iout4

! ntvactf = (x nsamp) sample frequency velocity auto correlation
!              function
INTEGER :: ntvacf

! SAMP1 = .true. conventional scheme to determine diffusion is used
LOGICAL :: SAMP1

! SAMP2 = .true. order N scheme to determine diffusion is used
LOGICAL :: SAMP2

! TDIFMAX = maximum time to determine diffusion
REAL(8) :: TDIFMAX

END MODULE