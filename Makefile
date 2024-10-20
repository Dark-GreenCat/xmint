SCRIPTS_DIR = scripts

install-ibex:
	-git clone https://github.com/lowRISC/ibex.git
	./$(SCRIPTS_DIR)/install-ibex.sh