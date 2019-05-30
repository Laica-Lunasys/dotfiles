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

#### Ubuntu Setup
ubuntu: ## Setup Ubuntu Environment
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/ubuntu/00_remove.sh
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/ubuntu/01_install.sh

nvidia: ## Setup Ubuntu NVIDIA Driver
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/ubuntu/01_install-nvidia.sh

docker: ## Setup Docker
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/ubuntu/01_install-nvidia.sh
gnome: ## Setup GNOME Environment
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/setup/gnome/00_setup.sh

#### ===
install: extract init ## Run make extract, init

clean: ## Remove dotfiles
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -rfv $(HOME)/$(val);)
	@echo 'Removing fzf...'
	@rm -rfv $(HOME)/.fzf
	@echo 'Removing Antigen...'
	@rm -rfv $(HOME)/.antigen
	@echo 'Removing zplug...'
	@rm -rfv $(HOME)/.zplug
	@echo 'Removing vim bundles...'
	@rm -rfv $(DOTPATH)/.vim/bundle
	@rm -rfv $(DOTPATH)/.vim/plugged

reinstall: clean install ## Reinstall Dotfiles Environment
	@exec $$SHELL -c "echo 'pong' && exit 0"

help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
