ANSIBLE_PLAYBOOK:= HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i .inventory

.PHONY: all
all: xdg-config ansible-playbook


.PHONY: ansible-playbook
ansible-playbook: ansible
	cd ansible
	$(ANSIBLE_PLAYBOOK) playbook.yml


.PHONY: xdg-config
xdg-config:
	ln -fns $(shell pwd) ${HOME}/.config


.PHONY: git
git: homebrew
ifeq ($(shell type git 2> /dev/null),)
	brew install git
endif


.PHONY: ansible
ansible: homebrew
ifeq ($(shell type ansible-playbook 2> /dev/null),)
	brew install ansible
endif


.PHONY: homebrew
homebrew:
ifeq ($(shell type brew 2> /dev/null),)
	/usr/bin/ruby -e \
"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
