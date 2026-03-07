# =================================================
# ECE 581 Final Project: Ibex RISC-V Core
# Marco Martinez Corral 04-MAR:
# Run this from syn/ by typing "make dc"
# Don't forget to run "make clean" after it's done
# ASIC Synthesis Makefile for Ibex RISC-V Sweep
# 06-MAR: implementing syn/ directory after having issues
# =================================================

# User-configurable variables
TOP        ?= ibex_demo_system
DC_SHELL   ?= dc_shell

# WARD = syn/ directory
# ROOT = FINAL_REPO_ROOT (one level up)
WARD       := $(shell pwd)
ROOT       := $(WARD)/..

# Directories inside syn/
SCRIPTDIR  := $(WARD)/scripts
RTLDIR     := $(WARD)/rtl
WORK_DIR   := $(WARD)/work

# Directories at FINAL_REPO_ROOT level (outside syn/)
LOGDIR     := $(ROOT)/logs
REPORTS    := $(ROOT)/reports
OUTPUTS    := $(ROOT)/outputs

# Export so TCL scripts can see them
export RTLDIR
export TOP

.DEFAULT_GOAL := help

.PHONY: dc clean help

# -----------------------------
# DC Synthesis Sweep
# -----------------------------
dc:
	@mkdir -p $(LOGDIR) $(REPORTS) $(OUTPUTS) $(WORK_DIR)
	@echo "=============================================="
	@echo " Running Multi-Frequency Synthesis Sweep"
	@echo " Target: $(TOP)"
	@echo " syn dir:     $(WARD)"
	@echo " rtl dir:     $(RTLDIR)"
	@echo " reports out: $(REPORTS)"
	@echo " outputs out: $(OUTPUTS)"
	@echo "=============================================="
	$(DC_SHELL) -64bit -f $(SCRIPTDIR)/dc_top.tcl | tee $(LOGDIR)/$(TOP)_dc.log

# -----------------------------
# Cleanup
# -----------------------------
clean:
	@echo "Cleaning synthesis outputs..."
	rm -rf $(WORK_DIR) $(REPORTS) $(OUTPUTS) $(LOGDIR)
	rm -f $(WARD)/*.svf $(WARD)/*.log $(WARD)/command.log $(WARD)/alib-*

# -----------------------------
# Help Menu
# -----------------------------
help:
	@echo "=============================================="
	@echo " RTL to DC Synthesis Flow (Multi-Freq Sweep)"
	@echo "=============================================="
	@echo ""
	@echo "Usage: run from the syn/ directory"
	@echo ""
	@echo "TARGETS:"
	@echo "  make dc      - Run the full synthesis sweep"
	@echo "  make clean   - Remove all generated outputs"
	@echo "  make help    - Display this menu"
	@echo ""
	@echo "OUTPUT LOCATIONS:"
	@echo "  logs/        $(ROOT)/logs/"
	@echo "  reports/     $(ROOT)/reports/"
	@echo "  outputs/     $(ROOT)/outputs/"
	@echo "  work/        $(WARD)/work/"
	@echo ""
