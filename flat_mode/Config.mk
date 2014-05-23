ifndef CONFIG_
CONFIG_ := 1

###################### IGNORE ABOVE ###############################
#y or leave it empty
DEBUG      := y
DEBUG_DIR  := debug
RELEASE_DIR:= release

SrcBase    := #src/
MkfileDir  := #./
SubDirs    := #compile subdirs
AllRunners := #make run

IncDirs    := $(SrcBase)include $(SrcBase)cmd1/libC
LibDirs    := #-L/usr/include/mysql

CC         := gcc
CFLAGS     := #-m32 -Wall -Werror -Wextra -Wmissing-prototypes -Wstrict-prototypes -Wunused-value -Wno-unused-parameter -Wformat \
  -Wfloat-equal -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings -Wredundant-decls
DFLAGS     := #macros
LDFLAGS    := #-lpthread -lmysqlclient
ARFLAGS    := -cr

###################### IGNORE BELOW ###############################
# if none-config, build default values
ifeq ($(strip $(SrcBase)),)
SrcBase := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
endif

ifeq ($(strip $(DEBUG)),y)
CFLAGS     += -g -O0
else
CFLAGS     += -O3
endif


ifeq ($(strip $(DEBUG)),y)
OutputDir  := $(DEBUG_DIR)
$(info "Building Debug Version, output $(OutputDir) ..." )
else
OutputDir  := $(RELEASE_DIR)
$(info "Building Release Version, output $(OutputDir) ..." )
endif

ifeq ($(strip $(OutputDir)),)
Arch := $(shell uname -s)_$(shell uname -m)
_tbase := $(SrcBase)$(Arch)
else
_tbase := $(SrcBase)$(OutputDir)
endif

ifeq ($(strip $(SubDirs)),)
SubDirs := $(shell pushd $(SrcBase) > /dev/null; \
	find * -name Makefile -print0 | xargs -0 -n1 dirname | grep -v '^\.$$'; \
	popd > /dev/null; \
	)
endif

ifeq ($(strip $(AllRunners)),)
AllRunners := $(shell find $(_tbase) -executable -type f)
endif

######################################################################

endif ## CONFIG_
