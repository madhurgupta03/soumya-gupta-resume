# -------------------------------------------------------
# Makefile — Resume Builder
#
# Usage:
#   make                                    # show help
#   make list                               # list all profiles
#   make <profile>                          # compile a profile
#   make <profile> ROLE="My_Role_Label"     # compile with custom role label
#   make all                                # compile every profile
#   make clean                              # remove all output PDFs
#
# Examples:
#   make base-data-analyst
#   make base-data-engineer   ROLE="DataEngineer_v2"
#   make company-swiggy       ROLE="Analyst_TrustSafety"
# -------------------------------------------------------

SHELL := /bin/bash
ROLE  ?=

# Auto-discover all profile folders
PROFILES := $(patsubst ./%,%,$(shell find . -maxdepth 1 -type d \( -name 'base-*' -o -name 'company-*' \) | sort))

# ── Default target ────────────────────────────────────
.DEFAULT_GOAL := help

.PHONY: help list all clean $(PROFILES)

# ── Help ─────────────────────────────────────────────
help:
	@echo ""
	@echo "  Resume Builder — Makefile"
	@echo ""
	@echo "  Usage:"
	@echo "    make <profile>                       compile a profile"
	@echo "    make <profile> ROLE=\"Label\"        compile with custom role label"
	@echo "    make all                             compile every profile"
	@echo "    make list                            list available profiles"
	@echo "    make clean                           remove all output PDFs"
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

# ── Compile all profiles ──────────────────────────────
all: $(PROFILES)

# ── Pattern rule — matches any base-* or company-* ───
$(PROFILES):
	@bash compile.sh "$@" "$(ROLE)"

# ── Clean all output PDFs ─────────────────────────────
clean:
	@echo "Removing all output PDFs..."
	@find output -name "*.pdf" -delete 2>/dev/null && echo "  Done." || echo "  Nothing to clean."
