.DEFAULT_GOAL := help

list: ## Show dotfiles in this repo
	@bash $(PWD)/init.sh list

install: ## Install dotfiles
	@bash $(PWD)/init.sh install

extract: ## Extract only
	@bash $(PWD)/init.sh extract

clean: ## Remove dotfiles
	@bash $(PWD)/init.sh clean
	@bash $(PWD)/setup/wsl.sh clean

reinstall: clean install ## Reinstall dotfiles Environment

wsl-paths: ## Extract WSL paths
	@bash $(PWD)/setup/wsl.sh install

help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
