DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dotfiles in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

extract: ## Create symlink to home directory
	@echo '==> Extracting...'
	@$(foreach val, $(DOTFILES), ln -snfv $(abspath $(val)) $(HOME)/$(val);)

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/init.sh

update: ## Fetch changes for this repository
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update extract init ## Run make update, extract, init
	@echo '==> Starting Shell...'
	@exec $$SHELL

clean: ## Remove dotfiles
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/$(val);)
	@echo 'Removing Antigen...'
	@rm -rfv $(HOME)/.antigen
	@echo 'Removing vim bundles...'
	@rm -rfv $(DOTPATH)/.vim/bundle

reinstall: clean install ## Reinstall Dotfiles Environment
	@exec $$SHELL

help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
