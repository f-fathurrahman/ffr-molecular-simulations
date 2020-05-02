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
!
  USE m_globals, ONLY: x, y, z, npart, hbox, box
  IMPLICIT NONE
 
  REAL(8) :: Xi, Yi, Zi, En, dx, dy, dz, r2, Vir, virij, enij
  INTEGER :: I, j, Jb

  En = 0.d0
  Vir = 0.d0
  DO j = Jb, NPART
    IF( j /= I ) THEN
      dx = Xi - X(j)
      dy = Yi - Y(j)
      dz = Zi - Z(j)
      
      IF (dx > HBOX) THEN
        dx = dx - BOX
      ELSE
        IF (dx < -HBOX) dx = dx + BOX
      END IF
      
      IF (dy > HBOX) THEN
        dy = dy - BOX
      ELSE
        IF (dy < -HBOX) dy = dy + BOX
      END IF
      
      IF (dz > HBOX) THEN
        dz = dz - BOX
      ELSE
        IF (dz < -HBOX) dz = dz + BOX
      END IF
      
      r2 = dx*dx + dy*dy + dz*dz
      CALL ENER(enij, virij, r2)
      En = En + enij
      Vir = Vir + virij
    ENDIF
  ENDDO
  
  RETURN

END SUBROUTINE
