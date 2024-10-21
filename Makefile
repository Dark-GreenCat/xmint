SCRIPTS_DIR = scripts

install-ibex:
	-git clone https://github.com/lowRISC/ibex.git ibex
	./$(SCRIPTS_DIR)/install-ibex.sh

install-riscv-compliance:
	-git clone https://github.com/riscv/riscv-compliance.git -b old-framework-2.x riscv-compliance
	./$(SCRIPTS_DIR)/install-riscv-compliance.sh
