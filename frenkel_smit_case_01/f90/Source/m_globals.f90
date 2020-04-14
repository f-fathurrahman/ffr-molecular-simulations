MODULE m_globals

! npmax: maximum number of particles
INTEGER, PARAMETER :: npmax=10000

! box      : simulation box length
! hbox     : 0.5 * box
! temp     : temperature
! beta     : 1/temp
REAL(8) :: box, temp, beta, hbox

REAL(8), PARAMETER :: pi=4.d0*atan(1.d0)

! eps4      : 4 * epsilon 
! eps48     : 48 * epsilon
! (epsilon) : energy parameter Lennard-Jones potential
! sig2      : sigma*sigma
! (sigma)   : size parameter Lennard-Jones potenital
! mass      : mass of the molecules
! rc        : cut-off radius of the potenial
! rc2       : rc * rc
! ecut      : energy at cut-off radius
! tailco    : .true. apply tail corrections
! shift     : .true. shift the potential
REAL(8) :: eps4, sig2, mass, ecut, rc2, eps48,rc
LOGICAL :: tailco, shift

! x(i),y(i),z(i)    : position particle i
! npart             : actual number of particles
REAL(8) :: x(npmax), y(npmax), z(npmax)
INTEGER :: npart



END MODULE