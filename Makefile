BIN   = ./bin/brown
SHELL = /bin/bash

CASKDEPS  = osxfuse virtualbox vagrant
OTHERDEPS = sshfs
DEPS     = $(CASKDEPS) $(OTHERDEPS)

SSHDIRS = home course
VM      = vagrant

my_info = $(info ----> MAKE $(1))

.PHONY: start stop install init mount umount start_vm stop_vm ssh clean extra_clean

start: mount start_vm
stop: stop_vm umount

install: $(DEPS)

init: .uname

mount: .uname $(SSHDIRS)
	$(call my_info,mounting $(SSHDIRS)...)
	@$(BIN) mount

umount: init
	$(call my_info,unmounting $(SSHDIRS)...)
	@$(BIN) umount

start_vm:
	$(call my_info,starting vm...)
	@$(VM) up

stop_vm:
	$(call my_info,stopping vm...)
	@$(VM) halt

ssh:
	$(call my_info,ssh-ing into vm...)
	@$(VM) ssh

.uname:
	$(call my_info,initializing...)
	@$(BIN) init $(shell read -p "brown login: "; echo $$REPLY)

$(CASKDEPS):
	$(call my_info,installing $@)
ifeq ($(shell uname -s),Darwin)
	@brew cask install Caskroom/cask/$@
else
	@echo "install $@ manually"
endif

$(OTHERDEPS):
	$(call my_info,installing $@)
ifeq ($(shell uname -s),Darwin)
	@brew install $@
else
	@echo "install $@ manually"
endif

$(SSHDIRS):
	@mkdir -p $@

clean: stop
	$(call my_info, deleting .uname $(SSHDIRS)...)
	@rm -rf $(SSHDIRS)

extra_clean: clean
	@rm -f .uname
