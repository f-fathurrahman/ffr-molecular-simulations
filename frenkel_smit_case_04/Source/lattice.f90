SUBROUTINE lattice()
  
  USE m_globals  
  ! place `npart' particles on a simple cubic
  ! lattice with density 'rho'
  IMPLICIT NONE
  
  INTEGER :: i, j, k, itel, n
  REAL(8) :: dx, dy, dz, del
 
  n = INT(NPART**(1./3.)) + 1
   
  IF( n == 0) n = 1
   
  del = BOX/DBLE(n)
  write(*,*) 'n = ', n
  write(*,*) 'box = ', box
  write(*,*) 'del = ', del

  itel = 0
  dx = -del
  
  write(*,*) 'dx = ', dx

  DO i = 1, n
    dx = dx + del
    dy = -del
    
    DO j = 1, n
      dy = dy + del
      dz = -del
      
      DO k = 1, n
        dz = dz + del
        
        !write(*,*) 'dz = ', dz
        IF( itel < NPART ) THEN
          itel = itel + 1
          !write(*,*) 'Pass here 34'
          X(itel) = dx
          Y(itel) = dy
          Z(itel) = dz
          !write(*,*) 'Pass here 38'
        ENDIF
      
      ENDDO
    
    ENDDO
  
  ENDDO
  
  WRITE(*, 99001) itel
  
  RETURN

99001 FORMAT (' Initialisation on lattice: ', /, i10, &
              ' particles placed on a lattice')

END
