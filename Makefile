# ------------------------------------------
# Makefile: Clojure Service
#
# Consistent set of targets to support local development of Clojure
# and build the Clojure service during CI deployment
#
# Requirements
# - cljstyle
# - Clojure CLI aliases
#   - `:env/dev` to include `dev` directory on class path
#   - `:env/test` to include `test` directory and libraries to support testing
#   - `:test/run` to run kaocha kaocha test runner and supporting paths and dependencies
#   - `:repl/rebel` to start a Rebel terminal UI
#   - `:package/uberjar` to create an uberjar for the service
# - docker
# - mega-linter-runner
#
# ------------------------------------------
# .PHONY: ensures target used rather than matching file name
# https://makefiletutorial.com/#phony
.PHONY: all clean  deps dist lint pre-commit-check repl test test-ci test-watch 

# ------- Makefile Variables --------- #
# run help if no target specified
.DEFAULT_GOAL := help

OUTDATED_FILE := outdated-$(shell date +%y-%m-%d-%T).org

# Column the target description is printed from
HELP-DESCRIPTION-SPACING := 24

# Makefile file and directory name wildcard
# EDN-FILES := $(wildcard *.edn)

# Tool variables
# MEGALINTER_RUNNER = npx mega-linter-runner --flavor documentation --env "'MEGALINTER_CONFIG=.github/config/megalinter.yaml'" --remove-container
MEGALINTER_RUNNER = npx mega-linter-runner --flavor java --env "'MEGALINTER_CONFIG=.github/config/megalinter.yaml'" --remove-container
# ------------------------------------ #

# ------- Help ----------------------- #
# Source: https://nedbatchelder.com/blog/201804/makefile_help_target.html

help:  ## Describe available tasks in Makefile
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
	sort | \
	awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-$(HELP-DESCRIPTION-SPACING)s\033[0m %s\n", $$1, $$2}'
# ------------------------------------ #

# ------- Clojure Projects -------- #
project-service:  ## New project with practicalli/service template
	$(info --------- Create Service Project ---------)
	clojure -T:project/create :template practicalli/service :name practicalli/gameboard

project-service-donut:  ## New project with practicalli/service template & Donut
	$(info --------- Create Service Project with Donut ---------)
	clojure -T:project/create :template practicalli/service :name practicalli/gameboard :target-dir gameboard-donut

project-service-integrant:  ## New project with practicalli/service template & Integrant
	$(info --------- Create Service Project with Integrant ---------)
	clojure -T:project/create :template practicalli/service :name practicalli/gameboard :target-dir gameboard-integrant

landing-page-local:  ## New project with practicalli/landing-page template local
	$(info --------- Run Rebel REPL ---------)
	clojure -T:project/create-local :template practicalli/landing-page :name practicalli/landing-page-local

landing-page:  ## New project with practicalli/landing-page template local
	$(info --------- Run Rebel REPL ---------)
	clojure -T:project/create :template practicalli/landing-page :name practicalli/landing-page

outdated: ## Check deps.edn & GitHub actions for new versions
	$(info --------- Search for outdated libraries ---------)
	- clojure -T:search/outdated > $(OUTDATED_FILE)

# ------- Clojure Workflow -------- #
repl:  ## Run Clojure REPL with rich terminal UI (Rebel Readline)
	$(info --------- Run Rebel REPL ---------)
	clojure -M:test/env:repl/reloaded


# deps: deps.edn  ## Prepare dependencies for test and dist targets
#		$(info --------- Download test and service libraries ---------)
#		clojure -P -X:build

# dist: deps build-uberjar ## Build and package Clojure service
#		$(info --------- Build and Package Clojure service ---------)

# Remove files and directories after build tasks
# `-` before the command ignores any errors returned
clean:  ## Clean build temporary files
	$(info --------- Clean Clojure classpath cache ---------)
	- rm -rf ./.cpcache ./.clj-kondo ./.lsp
# ------------------------------------ #

# ------- Testing -------------------- #
# test-config:  ## Print Kaocha test runner configuration
#			$(info --------- Runner Configuration ---------)
#			clojure -M:test/env:test/run --print-config

# test-profile:  ## Profile unit test speed, showing 3 slowest tests
#			$(info --------- Runner Profile Tests ---------)
#			clojure -M:test/env:test/run --plugin  kaocha.plugin/profiling

# test:  ## Run unit tests - stoping on first error
#			$(info --------- Runner for unit tests ---------)
#			clojure -X:test/env:test/run

# test-all:  ## Run all unit tests regardless of failing tests
#			$(info --------- Runner for all unit tests ---------)
#			clojure -X:test/env:test/run :fail-fast? false

# test-watch:  ## Run tests when changes saved, stopping test run on first error
#			$(info --------- Watcher for unit tests ---------)
#			clojure -X:test/env:test/run :watch? true

# test-watch-all:  ## Run all tests when changes saved, regardless of failing tests
#			$(info --------- Watcher for unit tests ---------)
#			clojure -X:test/env:test/run :fail-fast? false :watch? true
# ------------------------------------ #

# -------- Build tasks --------------- #
# build-config: ## Pretty print build configuration
#		$(info --------- View current build config ---------)
#		clojure -T:build config

# build-jar: ## Build a jar archive of Clojure project
#		$(info --------- Build library jar ---------)
#		clojure -T:build jar

# build-uberjar: ## Build a uberjar archive of Clojure project & Clojure runtime
#		$(info --------- Build service Uberjar  ---------)
#		clojure -T:build uberjar

# build-clean: ## Clean build assets or given directory
#		$(info --------- Clean Build  ---------)
#		clojure -T:build clean
# ------------------------------------ #

# ------- Code Quality --------------- #
pre-commit-check: format-check lint test  ## Run format, lint and test targets

format-check: ## Run cljstyle to check the formatting of Clojure code
	$(info --------- cljstyle Runner ---------)
	cljstyle check

format-fix:  ## Run cljstyle and fix the formatting of Clojure code
	$(info --------- cljstyle Runner ---------)
	cljstyle fix

lint:  ## Run MegaLinter with custom configuration (node.js required)
	$(info --------- MegaLinter Runner ---------)
	$(MEGALINTER_RUNNER)

lint-fix:  ## Run MegaLinter with applied fixes and custom configuration (node.js required)
	$(info --------- MegaLinter Runner ---------)
	$(MEGALINTER_RUNNER) --fix

lint-clean:  ## Clean MegaLinter report information
	$(info --------- MegaLinter Clean Reports ---------)
	- rm -rf ./megalinter-reports

megalinter-upgrade:  ## Upgrade MegaLinter config to latest version
	$(info --------- MegaLinter Upgrade Config ---------)
	npx mega-linter-runner@latest --upgrade
# ------------------------------------ #

# ------- Docker Containers ---------- #
# docker-build:  ## Build Clojure Service with docker compose
#		$(info --------- Docker Compose Build ---------)
#		docker compose up --build

# docker-build-clean:  ## Build Clojure Service with docker compose, removing orphans
#		$(info --------- Docker Compose Build - remove orphans ---------)
#		docker compose up --build --remove-orphans

# docker-down:  ## Shut down Clojure service using docker compose
#		$(info --------- Docker Compose Down ---------)
#		docker-compose down

# swagger-editor:  ## Start Swagger Editor in Docker
#		$(info --------- Run Swagger Editor at locahost:8282 ---------)
#		docker compose -f swagger-editor.yml up -d swagger-editor

# swagger-editor-down:  ## Stop Swagger Editor in Docker
#		$(info --------- Run Swagger Editor at locahost:8282 ---------)
#		docker compose -f swagger-editor.yml down
# ------------------------------------ #

# ------ Continuous Integration ------ #
# .DELETE_ON_ERROR: halts if command returns non-zero exit status
# https://makefiletutorial.com/#delete_on_error

# TODO: focus runner on ^:integration` tests
# test-ci: deps  ## Test runner for integration tests
#		$(info --------- Runner for integration tests ---------)
#		clojure -P -X:test/env:test/run

# Run tests, build & package the Clojure code and clean up afterward
# `make all` used in Docker builder stage
# .DELETE_ON_ERROR:
# all: test-ci dist clean  ## Call test-ci dist and clean targets, used for CI
# ------------------------------------ #
