MODULE m_globals

REAL(8), PARAMETER :: pi=4.d0*atan(1.d0)


! npmax: maximum number of particles
INTEGER, PARAMETER :: npmax=10000

! positions of particle i
REAL(8) :: x(npmax)
real(8) :: y(npmax)
real(8) :: z(npmax)
! FIXME: make this allocatable

! actual number of particles
INTEGER :: npart

! simulation box length
real(8) :: box

! 0.5 * box
real(8) :: hbox

! temperature
real(8) :: temp

! 1/temp
real(8) :: beta

! 4*epsilon
real(8) :: eps4

! 48 * epsilon
real(8) :: eps48

! (epsilon) : energy parameter Lennard-Jones potential
real(8) :: epsilon

! sigma*sigma
real(8) :: sig2

! size parameter Lennard-Jones potenital
real(8) :: sigma

! mass : mass of the molecules
real(8) :: mass

! cut-off radius of the potenial
real(8) :: rc
real(8) :: rc2

! energy at cut-off radius
real(8) :: ecut

! if .true. apply tail corrections
logical :: tailco

! if .true. shift the potential
logical :: shift

END MODULE