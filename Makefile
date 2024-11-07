Vibex-simple-system ?= ibex/build/lowrisc_ibex_ibex_simple_system_0/sim-verilator/Vibex_simple_system
IBEX_SIMPLE_SYSTEM_SW ?= ibex/examples/sw/simple_system/hello_test/hello_test.vmem
IBEX_SIMPLE_SYSTEM_TERM_AFTER_CYCLE ?= 0
IBEX_SIMPLE_SYSTEM_WAVEFORM_FILENAME ?= ibex_simple_system

Vibex-demo-system ?= ibex-demo-system/build/lowrisc_ibex_demo_system_0/sim-verilator/Vtop_verilator
IBEX_DEMO_SYSTEM_SW ?= ibex-demo-system/sw/c/build/demo/hello_world/demo
IBEX_DEMO_SYSTEM_TERM_AFTER_CYCLE ?= 1000000
IBEX_DEMO_SYSTEM_WAVEFORM_FILENAME ?= ibex_demo_system

SCRIPTS_DIR := scripts

install-ibex:
	-cp -f "./$(SCRIPTS_DIR)/resources/config-sim.sh.ibex-and-ibex-demo-system" "config-sim.sh"
	-git clone https://github.com/lowRISC/ibex.git ibex
	-cd ibex && git checkout fb49826c16aab4902f2bedb5456f2f9ec118a97a && cd ..
	./$(SCRIPTS_DIR)/install-ibex.sh

install-riscv-compliance:
	-git clone https://github.com/riscv/riscv-compliance.git -b old-framework-2.x riscv-compliance
	./$(SCRIPTS_DIR)/install-riscv-compliance.sh

install-ibex-demo-system: install-ibex
	-cp -f "./$(SCRIPTS_DIR)/resources/config-sim.sh.ibex-and-ibex-demo-system" "config-sim.sh"
	-git clone https://github.com/lowRISC/ibex-demo-system.git ibex-demo-system
	-cd ibex-demo-system && git checkout a1201cf2b99f8f4149c0971c04c655adbf1753c4 && cd ..
	./$(SCRIPTS_DIR)/install-ibex-demo-system.sh

integrate-xmint-to-ibex:
	./$(SCRIPTS_DIR)/integrate-xmint-to-ibex.sh

integrate-xmint-to-ibex-demo-system:
	./$(SCRIPTS_DIR)/integrate-xmint-to-ibex-demo-system.sh

uninstall-xmint-from-ibex:
	-cd ibex && git restore . && git clean -f && git reset --hard fb49826c16aab4902f2bedb5456f2f9ec118a97a && cd ..

uninstall-xmint-from-ibex-demo-system:
	-cd ibex-demo-system && git restore . && git clean -f && git reset --hard a1201cf2b99f8f4149c0971c04c655adbf1753c4 && cd ..
	cp "./$(SCRIPTS_DIR)/resources/Makefile.ibex-demo-system" "./ibex-demo-system/Makefile"

tidy-up:
	-rm *.fst *.log *.csv

run-simple-system:
	$(Vibex_simple_system) --raminit=$(IBEX_SIMPLE_SYSTEM_SW) -t -c $(IBEX_SIMPLE_SYSTEM_TERM_AFTER_CYCLE)
	@echo ""
	@echo "============================"
	@echo "Change waveform file name to: $(IBEX_SIMPLE_SYSTEM_WAVEFORM_FILENAME)"
	-mv sim.fst $(IBEX_SIMPLE_SYSTEM_WAVEFORM_FILENAME).fst

run-demo-system:
	$(Vibex_demo_system) --raminit=$(IBEX_DEMO_SYSTEM_SW) -t -c $(IBEX_DEMO_SYSTEM_TERM_AFTER_CYCLE)
	@echo ""
	@echo "============================"
	@echo "Change waveform file name to: $(IBEX_DEMO_SYSTEM_WAVEFORM_FILENAME)"
	-mv sim.fst $(IBEX_DEMO_SYSTEM_WAVEFORM_FILENAME).fst
