SUBROUTINE lattice()
  
  USE m_globals, ONLY: npart, box, x, y, z
  ! place `npart' particles on a simple cubic
  ! lattice with density 'rho'
  IMPLICIT NONE
  
  INTEGER :: i, j, k, itel, n
  REAL(8) :: dx, dy, dz, del
  REAL(8), PARAMETER :: LJ2ANG = 3.4d0

  n = INT(npart**(1.d0/3.d0)) + 1
  IF( n == 0) n = 1
   
  del = BOX/DBLE(n)
  
  WRITE(*,*) 'n   = ', n
  WRITE(*,'(1x,A,F18.10)') 'del = ', del

  itel = 0
  dx = -del

  DO i = 1, n
    dx = dx + del
    dy = -del
    DO j = 1, n
      dy = dy + del
      dz = -del
      DO k = 1, n
        dz = dz + del        
        IF( itel < NPART ) THEN
          itel = itel + 1
          X(itel) = dx
          Y(itel) = dy
          Z(itel) = dz
          WRITE(100,'(1x,A,3F18.10)') 'Ar ', x(itel)*LJ2ANG, y(itel)*LJ2ANG, z(itel)*LJ2ANG
        ENDIF
      ENDDO
    ENDDO
  ENDDO
  
  WRITE(*,*)
  WRITE(*,'(1x,A,I10,A)') 'Initialization on lattice: ', itel, ' particles placed on a lattice'
  
  RETURN

END
