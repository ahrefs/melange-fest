project_name = melange-fest

DUNE = opam exec -- dune

.DEFAULT_GOAL := help

DUNE_BUILD_DIR := $(shell pwd)/_build

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 5.1.1 -y --deps-only

.PHONY: init
init: create-switch install ## Configure everything to develop this repository in local

.PHONY: install
install: ## Install development dependencies
	npm install
	opam update
	opam install -y . --deps-only --with-test --with-doc

.PHONY: build
build: ## Build the project
	$(DUNE) build

.PHONY: build_verbose
build_verbose: ## Build the project
	$(DUNE) build --verbose

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	$(DUNE) clean

.PHONY: format
format: ## Format the codebase with ocamlformat
	$(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	$(DUNE) build --watch

.PHONY: test
test: ## Run test suite
	$(DUNE) build @runtest --no-buffer

.PHONY: docs
docs: ## Build the docs
	rm -rf _docs
	mkdir _docs
	cp docs/index.html _docs
	ODOC_SYNTAX=reason $(DUNE) build @doc
	mv _build/default/_doc/_html/odoc.support _docs
	mv _build/default/_doc/_html/melange-fest _docs/reason
	ODOC_SYNTAX=ocaml $(DUNE) build @doc
	mv _build/default/_doc/_html/melange-fest _docs/ocaml

.PHONY: preview
preview: docs ## Preview the docs
	cd _docs && python -m http.server
