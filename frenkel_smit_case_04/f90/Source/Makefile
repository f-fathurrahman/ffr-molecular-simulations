include make.inc

SRC = \
m_globals.f90 ranf.f90 rantest.f90 \
lattice.f90 init.f90 setvel.f90 velocs.f90 \
eneri.f90 toterg.f90 force.f90 \
sample.f90 store.f90 solve.f90


OBJ = $(SRC:.f90=.o) $(SRC:.f=.o)

#
# Suffix rule for Fortran 90
#
%.mod :
	@if [! -f $@ ]; then \
		rm $(*F).o; \
		fi
	$(MAKE) $<

%.o : %.f90
	$(F90) $(F90_OPTS) -c -o $(*F).o $<

#
# Fortran 77 sources
# supress warning
.SUFFIXES: .o .f
.f.o:
	$(F77) $(F77_OPTS) -c $<

# Targets
lib: $(OBJ)
	ar rcs libmain.a *.o

main: $(OBJ) lib
	$(F90) $(F90_OPTS) main.f90 libmain.a -o main.x

clean:
	rm -rf *.o *.mod libmain.a *.x


