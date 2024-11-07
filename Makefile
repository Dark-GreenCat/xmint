SCRIPTS_DIR := scripts

install-ibex:
	-git clone https://github.com/lowRISC/ibex.git ibex
	-cd ibex && git checkout fb49826c16aab4902f2bedb5456f2f9ec118a97a && cd ..
	./$(SCRIPTS_DIR)/install-ibex.sh

install-riscv-compliance:
	-git clone https://github.com/riscv/riscv-compliance.git -b old-framework-2.x riscv-compliance
	./$(SCRIPTS_DIR)/install-riscv-compliance.sh

install-ibex-demo-system: install-ibex
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
