##
## Copyright (C) 2012, xp@renzhi.ca
## All rights reserved.
##

GC             := 6g
LD             := 6l
O              := 6
MKDIR          := mkdir -p
RM             := rm -rf

SDIR           := src
ODIR           := obj
BDIR           := bin
TDIR           := test

#
# Add your list of package names here.
#
PKGS           := hello foo

SRC_DIR        := $(addprefix $(SDIR)/,$(PKGS)) $(SDIR)
OBJ_DIR        := $(addprefix $(ODIR)/,$(PKGS)) $(ODIR)

SRC            := $(foreach sdir,$(SRC_DIR),$(wildcard $(sdir)/*.go))
OBJ            := $(patsubst $(SDIR)/%.go,$(ODIR)/%.$O,$(SRC))
INC            := $(addprefix -I,$(OBJ_DIR)) -I$(ODIR)
LINK           := $(addprefix -L$(ODIR)/,$(PKGS)) -L$(ODIR)

TEST           := $(wildcard $(TDIR)/*.go)
TEST_OBJ       := $(patsubst $(TDIR)/%.go,$(ODIR)/%.$O,$(TEST))
TEST_PROG      := $(patsubst $(ODIR)/%.$O,$(BDIR)/%,$(TEST_OBJ))

#
# A directive to tell make to search for Go source files in
# in all directories as specified by SRC_DIR.
#
vpath %.go $(SRC_DIR)

define make-goal
$1/%.$O: %.go
	$(GC) $(INC) -o $$@ $$< 
endef

.PHONY: all checkdirs clean test

EXE=$(BDIR)/hello

all: checkdirs compile $(EXE)

$(EXE): $(ODIR)/main.$O
	@echo Linking $<
	$(LD) $(LINK) -o $@ $^

compile: $(OBJ)

#
# Check if the bin, obj and packages directories exist, if not,
# create them.
#
checkdirs: $(OBJ_DIR) $(BDIR)

$(OBJ_DIR):
	@$(MKDIR) $@

$(BDIR):
	@$(MKDIR) $@

test: checkdirs compile $(TEST_PROG)

$(TEST_OBJ): $(TEST)
	$(GC) $(INC) -o $@ $<

$(TEST_PROG): $(TEST_OBJ)
	$(LD) $(LINK) -o $@ $(subst $(BDIR),$(ODIR),$@).$O


clean:
	@$(RM) -rf $(OBJ_DIR) $(BDIR) Makefile.bak

#
# Create implicit rules for each build using the function make-goal,
# so that it is not necessary to list out all the source files
# one by one.
#
$(foreach bdir,$(OBJ_DIR),$(eval $(call make-goal,$(bdir))))
