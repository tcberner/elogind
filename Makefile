#if 0 /// The original Makefile follows, which isn't enough for elogind.
# all:
# 	ninja -C build
#
# install:
# 	DESTDIR=$(DESTDIR) ninja -C build install
#else // 0
.PHONY: all build clean install loginctl test test-login

# Set this to YES on the command line for a debug build
DEBUG      ?= NO

# Set this to yes to not build, but to show all build commands ninja would issue
JUST_PRINT ?= NO

HERE := $(shell pwd -P)

BUILDDIR  ?= $(HERE)/build
CGCONTROL ?= $(shell $(HERE)/tools/meson-get-cg-controller.sh)
CGDEFAULT ?= $(shell grep "^rc_cgroup_mode" /etc/rc.conf | cut -d '"' -f 2)
CONFIG    := $(BUILDDIR)/compile_commands.json
DESTDIR   ?=
MESON_LST := $(shell find $(HERE)/ -type f -name 'meson.build') $(HERE)/meson_options.txt
PREFIX    ?= /tmp/elogind_test
VERSION   ?= 9999

CC    ?= $(shell which cc)
LD    ?= $(shell which ld)
LN    := $(shell which ln) -s
MESON ?= $(shell which meson)
MKDIR := $(shell which mkdir) -p
RM    := $(shell which rm) -f

# Save users/systems choice
envCFLAGS   := ${CFLAGS}
envCXXFLAGS := ${CXXFLAGS}
envLDFLAGS  := ${LDFLAGS}

BASIC_OPT := --buildtype release
NINJA_OPT := -C $(BUILDDIR) --verbose

# Make sure "--just-print" gets translated over to ninja
ifneq (,$(findstring n,$(MAKEFLAGS)))
    FILTER_ME = n
    override MAKEFLAGS    := $(filter-out $(FILTER_ME),$(MAKEFLAGS))
    override MAKEOVERRIDE := $(MAKEFLAGS)
    # Explicitly set JUST_PRINT to "YES"
    JUST_PRINT := YES
endif

# Simulate --just-print?
ifeq (YES,$(JUST_PRINT))
    NINJA_OPT := ${NINJA_OPT} -t commands
endif

# Combine with "sane defaults"
ifeq (YES,$(DEBUG))
    BASIC_OPT := -Ddebug-extra=elogind -Dtests=unsafe --buildtype debug
    CFLAGS    := -O0 -g3 -ggdb -ftrapv ${envCFLAGS} -fPIE
    CXXFLAGS  := -O0 -g3 -ggdb -ftrapv ${envCXXFLAGS} -fPIE
    LDFLAGS   := ${envLDFLAGS} -fPIE
    NINJA_OPT := ${NINJA_OPT} -j 1 -k 1
else
    CFLAGS   := -O2 -fwrapv ${envCFLAGS}
    CXXFLAGS := -O2 -fwrapv ${envCXXFLAGS}
endif

# Finalize CFLAGS
CFLAGS := -march=native -pipe ${CFLAGS} -Wall -Wextra -Wunused -Wno-unused-parameter -Wno-unused-result -ftree-vectorize

all: build

build: $(CONFIG)
	+ninja $(NINJA_OPT)

clean: $(CONFIG)
	ninja $(NINJA_OPT) -t cleandead
	ninja $(NINJA_OPT) -t clean


install: build
	DESTDIR=$(DESTDIR) ninja $(NINJA_OPT) install

loginctl: $(CONFIG)
	ninja $(NINJA_OPT) $@

test: $(CONFIG)
	ninja -C $(BUILD) $@

test-login: $(CONFIG)
	ninja -C $(BUILD) $@

$(BUILDDIR):
	+$(MKDIR) $@

$(CONFIG): $(BUILDDIR) $(MESON_LST)
	+test -f $@ && ( \
		CC=$(CC) \
		LD=$(LD) \
		meson configure $(BUILDDIR) $(BASIC_OPT) \
	) || ( \
		CC=$(CC) \
		LD=$(LD) \
		meson setup $(BUILDDIR) $(BASIC_OPT) \
			--libdir lib64 \
			--libdir=$(PREFIX)/usr/lib64 \
			--localstatedir $(PREFIX)/var/lib \
			--prefix $(PREFIX) \
			--sysconfdir $(PREFIX)/etc \
			--wrap-mode nodownload  \
			-Dacl=true \
			-Dbashcompletiondir=$(PREFIX)/usr/share/bash-completion/completions \
			-Dcgroup-controller=$(CGCONTROL) \
			-Ddefault-hierarchy=$(CGDEFAULT) \
			-Ddocdir=$(PREFIX)/usr/share/doc/elogind-$(VERSION) \
			-Defi=true \
			-Dhtml=auto \
			-Dhtmldir=$(PREFIX)/usr/share/doc/elogind-$(VERSION)/html \
			-Dman=auto \
			-Dpam=true \
			-Dpamlibdir=$(PREFIX)/lib64/security \
			-Drootlibdir=$(PREFIX)/lib64 \
			-Drootlibexecdir=$(PREFIX)/lib64/elogind \
			-Drootprefix=$(PREFIX) \
			-Dselinux=false \
			-Dsmack=true \
			-Dudevrulesdir=$(PREFIX)/lib/udev/rules.d \
			-Dzshcompletiondir=$(PREFIX)/usr/share/zsh/site-functions \
	)

#endif // 0
