SUBROUTINE ENERI(Xi, Yi, Zi, I, Jb, En, Vir)
!
!    calculates the energy of particle I with particles j=jb,npart
!
!  Xi (input) x coordinate particle I
!  Yi (input) y coordinate particle I
!  Zi (input) z coordinate particle I
!  I  (input) particle number
!  Jb (input) = 0 calculates energy particle I with all other particle
!             = jb calculates energy particle I with all particles j > jb
!  En  (output) energy particle i
!  Vir (output) virial particle i
!
  USE m_globals
  IMPLICIT NONE
 
  REAL(8) :: Xi, Yi, Zi, En, dx, dy, dz, r2, Vir, virij, enij, r2i, r6i
 
  INTEGER :: I, j, Jb

  En = 0.D0
  Vir = 0.D0
  DO j = Jb, NPART
    IF( j /= I) THEN
      dx = Xi - X(j)
      dy = Yi - Y(j)
      dz = Zi - Z(j)
      !---periodic boundary conditions
      dx = dx - BOX*ANINT(dx/BOX)
      dy = dy - BOX*ANINT(dy/BOX)
      dz = dz - BOX*ANINT(dz/BOX)
      r2 = dx*dx + dy*dy + dz*dz
      IF (r2.LE.RC2) THEN
        r2i = 1/r2
        r6i = r2i*r2i*r2i
        enij = 4*(r6i*r6i-r6i) - ECUT
        virij = 48*(r6i*r6i-0.5D0*r6i)
        En = En + enij
        Vir = Vir + virij
      ENDIF
    ENDIF
  ENDDO

  RETURN

END SUBROUTINE
