BIN = ./bin/brown
SHELL = /bin/bash
OS = $(shell uname -s)

# shared dependancies
ALLDEPS = sshfs
FSDEPS = $(ALLDEPS)
# what will eventually get installed
DEPS = $(ALLDEPS)

# starting command
ALLSTRT = mount
STRT = $(ALLSTRT)
# ending command
ALLSTP = umount
STP = $(ALLSTP)

# OS X
ifeq ($(OS), Darwin)

FSDEPS += osxfuse
CASKDEPS = osxfuse virtualbox vagrant
# order matters
DEPS := $(CASKDEPS) $(DEPS)
# package manager
PM = brew
# virtual machine
VM = vagrant
STRT += start_vm
STP := stop_vm $(STP)

# Linux
else ifeq ($(OS), Linux)

PM = sudo apt-get

# other
else

PM = echo manually
endif

SSHDIRS = home course

my_info = $(info ----> MAKE $(strip $(1))...)

.PHONY: start stop \
		install install_fs init update \
		mount umount \
ifeq ($(OS), Darwin)
		start_vm stop_vm ssh \
endif
		clean clean_extra

all:
	$(warning run 'make update' to pull in latest code)
	@make start

start: $(STRT)

stop: $(STP)

install: $(DEPS)
install_fs: $(FSDEPS)

init: .uname

update:
	$(call my_info, updating)
	@git pull

mount: .uname
	$(call my_info, mounting $(SSHDIRS))
	@$(BIN) mount

umount: .uname
	$(call my_info, unmounting $(SSHDIRS))
	@$(BIN) umount

# OS X
ifeq ($(OS), Darwin)

start_vm:
	$(call my_info, starting vm)
	@$(VM) up

stop_vm:
	$(call my_info, stopping vm)
	@$(VM) halt

provision: start_vm
	$(call my_info, provisioning vm)
	@$(VM) $@

ssh:
	$(call my_info, ssh-ing into vm)
	@$(VM) $@

$(CASKDEPS):
	$(call my_info, installing $@)
	@$(PM) cask install Caskroom/cask/$@
endif

.uname:
	$(call my_info, initializing)
	@$(BIN) init $(shell read -p "brown login: "; echo $$REPLY)

$(ALLDEPS):
	$(call my_info, installing $@)
	@$(PM) install $@

clean: umount
	$(call my_info, deleting $(SSHDIRS))
	@rm -rf $(SSHDIRS)

clean_extra: clean
	$(call my_info, deleting .uname)
	@rm -f .uname
