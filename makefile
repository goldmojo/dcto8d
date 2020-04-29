# Project: dcto8d

OSTYPE=linux
#OSTYPE=gcw0

ifeq "$(OSTYPE)" "gcw0"	
TOOLCHAIN = /opt/gcw0-toolchain/usr
CC = $(TOOLCHAIN)/bin/mipsel-linux-gcc
LD = $(TOOLCHAIN)/bin/mipsel-linux-gcc
BINARY = dcto8d.dge
else
CC = gcc
LD = gcc
BINARY = dcto8d
endif

W_OPTS = -Wall -Wno-write-strings -Wno-sign-compare
F_OPTS = 

CDEFS = 

ifeq "$(OSTYPE)" "gcw0"	
CFLAGS = -Isource -I$(TOOLCHAIN)/mipsel-gcw0-linux-uclibc/sysroot/usr/include/SDL $(W_OPTS)
#CFLAGS = -D_GCW0_ -G0 -O3 -march=mips32 -mtune=mips32r2 -Isource -I$(TOOLCHAIN)/mipsel-gcw0-linux-uclibc/sysroot/usr/include/SDL -mhard-float -mbranch-likely -mno-mips16 $(W_OPTS) $(F_OPTS)
else
CFLAGS = $(W_OPTS) -Isource `sdl-config --cflags --libs`
endif

objects = object/dcto8dmain.o object/dc6809emul.o \
	object/dcto8dinterface.o object/dcto8ddevices.o object/dcto8demulation.o \
	object/dcto8dkeyb.o object/dcto8doptions.o object/dcto8dvideo.o \
	object/dc6809dass.o object/dcto8ddesass.o

all : $(objects)
	$(LD) $(objects) -o $(BINARY) $(CFLAGS)

object/dcto8dmain.o : source/dcto8dmain.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8dmain.c -o object/dcto8dmain.o -O2

object/dc6809emul.o : source/dc6809emul.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dc6809emul.c -o object/dc6809emul.o -O2

object/dcto8dinterface.o : source/dcto8dinterface.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8dinterface.c -o object/dcto8dinterface.o -O2

object/dcto8ddevices.o : source/dcto8ddevices.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8ddevices.c -o object/dcto8ddevices.o -O2

object/dcto8demulation.o : source/dcto8demulation.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8demulation.c -o object/dcto8demulation.o -O2

object/dcto8dkeyb.o : source/dcto8dkeyb.c source/dcto8dkeyb.h
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8dkeyb.c -o object/dcto8dkeyb.o -O2

object/dcto8doptions.o : source/dcto8doptions.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8doptions.c -o object/dcto8doptions.o -O2

object/dcto8dvideo.o : source/dcto8dvideo.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8dvideo.c -o object/dcto8dvideo.o -O2

object/dc6809dass.o: source/dc6809dass.c source/dc6809dass.h
	$(CC) $(CDEFS) $(CFLAGS) -c source/dc6809dass.c -o object/dc6809dass.o -O2

object/dcto8ddesass.o: source/dcto8ddesass.c
	$(CC) $(CDEFS) $(CFLAGS) -c source/dcto8ddesass.c -o object/dcto8ddesass.o -O2

clean :
	rm $(BINARY) $(objects)
