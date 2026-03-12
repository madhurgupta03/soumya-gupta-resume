# -------------------------------------------------------
# Makefile — Resume Builder
#
# Usage:
#   make                                    # show help
#   make list                               # list all profiles
#   make <profile>                          # compile a profile
#   make <profile> ROLE="My_Role_Label"     # compile with custom role label
#   make all                                # compile every profile
#   make build                              # (re)build the Docker image only
#   make clean                              # remove all output PDFs
#   make clean-image                        # remove the Docker image
#
# Examples:
#   make base-data-analyst
#   make base-data-engineer   ROLE="DataEngineer_v2"
#   make company-swiggy       ROLE="Analyst_TrustSafety"
# -------------------------------------------------------

SHELL      := /bin/bash
ROLE       ?=
IMAGE_NAME := resume-builder

# Auto-discover all profile folders
PROFILES := $(patsubst ./%,%,$(shell find . -maxdepth 1 -type d \( -name 'base-*' -o -name 'company-*' \) | sort))

# ── Default target ────────────────────────────────────
.DEFAULT_GOAL := help

.PHONY: help list all build clean clean-image $(PROFILES)

# ── Help ─────────────────────────────────────────────
help:
	@echo ""
	@echo "  Resume Builder — Makefile"
	@echo ""
	@echo "  Usage:"
	@echo "    make <profile>                       compile a profile"
	@echo "    make <profile> ROLE=\"Label\"          compile with custom role label"
	@echo "    make all                             compile every profile"
	@echo "    make list                            list available profiles"
	@echo "    make build                           (re)build the Docker image"
	@echo "    make clean                           remove all output PDFs"
	@echo "    make clean-image                     remove the Docker image"
	@echo ""
	@echo "  Profiles:"
	@for p in $(PROFILES); do echo "    $$p"; done
	@echo ""
	@echo "  Examples:"
	@echo "    make base-data-analyst"
	@echo "    make company-swiggy  ROLE=\"Analyst_TrustSafety\""
	@echo ""

# ── List profiles ─────────────────────────────────────
list:
	@echo ""
	@echo "  Available profiles:"
	@for p in $(PROFILES); do echo "    $$p"; done
	@echo ""

# ── Build Docker image only ───────────────────────────
build:
	@echo "Building Docker image '$(IMAGE_NAME)'..."
	@docker build --tag "$(IMAGE_NAME)" .
	@echo "  Done."

# ── Compile all profiles ──────────────────────────────
all: $(PROFILES)

# ── Pattern rule — matches any base-* or company-* ───
$(PROFILES):
	@bash compile.sh "$@" "$(ROLE)"

# ── Clean all output PDFs ─────────────────────────────
clean:
	@echo "Removing all output PDFs..."
	@find output -name "*.pdf" -delete 2>/dev/null && echo "  Done." || echo "  Nothing to clean."

# ── Remove Docker image ───────────────────────────────
clean-image:
	@echo "Removing Docker image '$(IMAGE_NAME)'..."
	@docker rmi "$(IMAGE_NAME)" 2>/dev/null && echo "  Done." || echo "  Image not found — nothing to remove."
