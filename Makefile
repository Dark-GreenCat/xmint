SCRIPTS_DIR = scripts

install-ibex:
	-git clone https://github.com/lowRISC/ibex.git ibex
	-cd ibex && git checkout fb49826c16aab4902f2bedb5456f2f9ec118a97a && cd ..
	./$(SCRIPTS_DIR)/install-ibex.sh

install-riscv-compliance:
	-git clone https://github.com/riscv/riscv-compliance.git -b old-framework-2.x riscv-compliance
	./$(SCRIPTS_DIR)/install-riscv-compliance.sh

integrate-xmint-to-ibex:
	./$(SCRIPTS_DIR)/integrate-xmint-to-ibex.sh

uninstall-xmint-from-ibex:
	-cd ibex && git restore . && git checkout fb49826c16aab4902f2bedb5456f2f9ec118a97a && cd ..
