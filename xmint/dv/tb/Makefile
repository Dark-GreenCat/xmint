CONFIG_FILE 	:= config.sh

VERILATOR 		?= verilator
VERILATOR_FLAGS ?= --binary --trace --timing -Wno-TIMESCALEMOD
OBJS_DIR 		:= obj_dir

TB_FILES 		?= tb_xmint_mux.v
RTL_FILES 		?= xmint_mux.v
RTL_DIR 		:= ../../rtl

GTKWAVE			?= gtkwave


SIMULATOR		= ./$(OBJS_DIR)/V$(basename $(TB_FILES))
WAVEFORM_FILE	= $(basename $(TB_FILES)).vcd
generate-config-file:
	cp "resources/$(CONFIG_FILE).tb" "$(CONFIG_FILE)"
	chmod +x $(CONFIG_FILE)

clean:
	rm -rf $(OBJS_DIR) *.vcd

build:
	$(VERILATOR) $(VERILATOR_FLAGS) $(TB_FILES) $(addprefix $(RTL_DIR)/, $(RTL_FILES))

run:
	$(SIMULATOR)

view-wave:
	$(GTKWAVE) $(WAVEFORM_FILE) > /dev/null 2>&1 &

.PHONY: generate-config-file clean build run view-wave