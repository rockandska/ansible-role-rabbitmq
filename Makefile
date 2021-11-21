.ONESHELL:
.DELETE_ON_ERROR:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
_SPACE = $(eval) $(eval)
_COMMA := ,

# invoking make V=1 will print everything
$(V).SILENT:

#####
# Functions
#####

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

define check_cmd_path
  $(eval
  _EXECUTABLE = $(1)
  _EXPECTED_PATH = $(2)
  _MSG = $(3)
  ifndef _EXECUTABLE
    $$(error Missing argument on 'check_cmd' call)
  endif
  $$(info Checking presence of '$$(_EXECUTABLE)')
  _CMD_PATH = $$(shell PATH="$$(PATH)" which $$(_EXECUTABLE))
  ifdef _CMD_PATH
    ifdef _EXPECTED_PATH
      ifneq ($$(_CMD_PATH),$$(_EXPECTED_PATH))
        ifneq ($$(_MSG),)
          $$(error $$(_MSG))
        endif
        ifeq ($$(_CMD_PATH),)
          $$(error Expecting '$$(_EXECUTABLE)' to be in '$$(_EXPECTED_PATH)' but is not installed)
        else
          $$(error Expecting '$$(_EXECUTABLE)' to be in '$$(_EXPECTED_PATH)' but found in '$$(_CMD_PATH)')
        endif
      endif
    endif
  else
    $$(error '$$(_EXECUTABLE)' not found in $$$$PATH)
  endif
  $$(info OK '$$(_EXECUTABLE)' found...)
  )
endef

#####
# vars
#####

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

# add venv bin to PATH
export PATH := $(MKFILE_DIR)/tmp/bin:$(PATH)

TESTS_TARGETS :=

#####
# Include
#####

-include $(MKFILE_DIR)/tmp/tox-env.mk

# Only remake tox-env once by run
ifndef MAKE_RESTARTS
$(MKFILE_DIR)/tmp/tox-env.mk: venv .FORCE
	$(info ### Generating targets based on tox environments + molecule scenarios... ###)
	$(call check_cmd_path,tox,$(MKFILE_DIR)/tmp/bin/tox)
	cat << 'EOF' > $(@)
		TEST_MOLECULE_SCENARIOS_LIST := $$(strip $$(notdir $$(patsubst %/,%, $$(dir $$(call rwildcard,$$(MKFILE_DIR)/molecule/,molecule.yml)))))
		TEST_TOX_TARGETS_PREFIX := test-tox
		TEST_TOX_ENV_LIST := $$(shell $$(MKFILE_DIR)/tmp/bin/tox -l)
		TEST_TOX_TARGETS := $$(addprefix $$(TEST_TOX_TARGETS_PREFIX)-,$$(foreach s,$$(TEST_MOLECULE_SCENARIOS_LIST),$$(addprefix $$(s)-,$$(TEST_TOX_ENV_LIST))))
		TESTS_TARGETS := $$(TESTS_TARGETS) $$(TEST_TOX_TARGETS)
	EOF
endif

#####
# Targets
#####

.PHONY: .FORCE
.FORCE:

.PHONY: all
all: test

.PHONY: test
test: $(TESTS_TARGETS)

.PHONY: $(TEST_TOX_TARGETS)
$(TEST_TOX_TARGETS): SCENARIO = $(strip $(foreach s,$(TEST_MOLECULE_SCENARIOS_LIST),$(subst $(TEST_TOX_TARGETS_PREFIX)-$(s)-,$(s),$(findstring $(TEST_TOX_TARGETS_PREFIX)-$(s)-,$(@)))))
$(TEST_TOX_TARGETS): TOX_ENV = $(strip $(foreach e,$(TEST_TOX_ENV_LIST),$(subst $(TEST_TOX_TARGETS_PREFIX)-$(SCENARIO)-$(e),$(e),$(findstring $(TEST_TOX_TARGETS_PREFIX)-$(SCENARIO)-$(e),$(@)))))
$(TEST_TOX_TARGETS): venv .github/workflows/pull_request.yml
	$(info ### Starting test with '$(TOX_ENV)' tox env and '$(SCENARIO)' molecule scenario)
	tox -e $(TOX_ENV) -- molecule test -s $(SCENARIO)

.github/workflows/pull_request.yml: tox.ini Makefile
	$(info ### Updating GHA pull_request workflow ###)
	docker run --rm -v "${PWD}":/workdir mikefarah/yq:4.9.6 -i eval '.jobs.Tests.strategy.matrix.target = [ "$(subst $(_SPACE),"$(_SPACE)$(_COMMA)$(_SPACE)",$(strip $(TESTS_TARGETS)))" ]' $@

##############
# Python env #
##############

.PHONY: venv
.SECONDARY: venv
venv: $(MKFILE_DIR)/tmp/bin/activate

.SECONDARY: $(MKFILE_DIR)/tmp/bin/activate
$(MKFILE_DIR)/tmp/bin/activate: $(MKFILE_DIR)/molecule/test-requirements.txt
	$(info ### Generating Python env ###)
	$(call check_cmd_path,python3)
	$(call check_cmd_path,pip3)
ifeq (, $(shell command -v virtualenv 2> /dev/null))
	$(info ##### Virtualenv not installed, try to install it...)
	pip3 install --quiet --quiet virtualenv
endif
ifdef VIRTUAL_ENV
	$(error VIRTUAL_ENV '$(VIRTUAL_ENV)' already set. Quit this VIRTUAL_ENV before running tests)
endif
	$(info Installing python3 tests requirements)
	virtualenv --quiet -p $(shell command -v python3) $(@D)/../
	VIRTUAL_ENV_DISABLE_PROMPT=true . $@
	pip install --quiet --quiet -Ur $<
	touch $@
