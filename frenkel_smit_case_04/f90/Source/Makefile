COMPFLAGS     =  -O # -check_bounds -trapeuv # -g 

CFLAGS	      = $(COMPFLAGS)
PFLAGS	      = $(COMPFLAGS)
FFLAGS	      = $(COMPFLAGS)
CCFLAGS       = $(COMPFLAGS)
CXXFLAGS      = $(COMPFLAGS)

DEST	      = .

# Uncomment this if you want system header files to be expanded
#
# SYSHDRS       =

EXTHDRS	      =

HDRS	      =
 
INSTALL	      = install

LD	      = gfortran

LDFLAGS	      = $(COMPFLAGS) # -l nag

LIBS	      = 

LINTLIBS      = 

LINTFLAGS     = -u $(CFLAGS)

MAKEFILE      = Makefile

OBJS	      = eneri.o \
		force.o \
		init.o \
		lattice.o \
		md.o \
		ranf.o \
		rantest.o \
		sample.o \
		setvel.o \
		solve.o \
		store.o \
		toterg.o \
		velocs.o

PRINT	      = pr

PRINTFLAGS    =

LP	      = lp

LPFLAGS       = 

PROGRAM       = MD

SHELL	      = /bin/sh

SRCS	      = eneri.f90 \
		force.f90 \
		init.f90 \
		lattice.f90 \
		md.f90 \
		ranf.f \
		rantest.f \
		sample.f90 \
		setvel.f90 \
		solve.f90 \
		store.f90 \
		toterg.f90 \
		velocs.f
# sample2.f90 \

all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) $(LIBS) $(MAKEFILE)
		@echo "Linking $(PROGRAM) ..."
		@$(LD) $(LDFLAGS) $(OBJS) $(LIBS) -o $(PROGRAM)
		@echo "done"

clean:;		@rm -f $(OBJS) core

clobber:;	@rm -f $(OBJS) $(PROGRAM) core tags

depend:;	@mkmf -f $(MAKEFILE) ROOT=$(ROOT)

echo:;		@echo $(HDRS) $(SRCS)

-1:;		@ctags -wx $(HDRS) $(SRCS)

install:	$(PROGRAM)
		@echo Installing $(PROGRAM) in $(DEST)
		@-strip $(PROGRAM)
		@if [ $(DEST) != . ]; then \
		(rm -f $(DEST)/$(PROGRAM); $(INSTALL) -f $(DEST) $(PROGRAM)); fi

lint:		$(LINTLIBS) $(SRCS) $(HDRS) $(EXTHDRS)
		lint $(LINTFLAGS) $(LINTLIBS) $(SRCS)

print:;		@$(PRINT) $(PRINTFLAGS) $(HDRS) $(SRCS) | $(LP) $(LPFLAGS)

tags:           $(HDRS) $(SRCS); @ctags $(HDRS) $(SRCS)

update:		$(DEST)/$(PROGRAM)

touch:;		@touch $(SRCS) $(HDRS)
