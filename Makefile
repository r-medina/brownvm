CASKDEPS  = osxfuse virtualbox vagrant
OTHERDEPS = sshfs
DEPS     = $(CASKDEPS) $(OTHERDEPS)

BIN = ./bin/brown

.PHONY: all init start install

all: init start

init:
	$(info initializing...)
	@$(BIN) init $(shell read -p "brown login: ";echo $$REPLY)

start: init
	$(info starting...)
	@$(BIN) up

install: $(DEPS)

$(CASKDEPS):
	$(info installing $@)
ifeq ($(shell uname -s), Darwin)
	brew cask install Caskroom/cask/$@
else
	@echo install $@ manually :(
endif

$(OTHERDEPS):
	$(info installing $@)
ifeq ($(shell uname -s), Darwin)
	@brew install $@
else
	@echo install $@ manually :(
endif
