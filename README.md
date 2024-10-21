# RISC-V Processor on FPGA | Digital Design 2023 Course

## Overview

This project implements a RISC-V processor using Verilog, aimed at providing a hands-on experience in digital design and FPGA development. The design focuses on the RISC-V architecture, demonstrating fundamental concepts in computer architecture, digital logic, and hardware description languages.

## Features

- **RISC-V Architecture**: Supports a subset of the RISC-V instruction set.
- **FPGA Implementation**: Designed for synthesis on FPGA platforms.
- **Modular Design**: Components are structured for easy modification and expansion.
- **Simulation and Testing**: Includes testbenches for verifying functionality.

## Getting Started

### Prerequisites

- A compatible FPGA development board (e.g., Xilinx, Intel/Altera)
- Verilog simulation tools (e.g., QuestaSim, Vivado)
- Synthesis tools (e.g., Quartus, Vivado)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Dark-GreenCat/RISC-V-Processor-on-FPGA-Digital-Design-2023-Course.git
   cd RISC-V-Processor-on-FPGA-Digital-Design-2023-Course
   ```

2. Install Ibex's environment
   ```bash
   make install-ibex
   ```

   - Follow the Makefile in the Ibex repository for more useful commands.
      - To run Simple System:
         ```bash
         cd ibex
         make sw-simple-hello build-simple-system run-simple-system IBEX_CONFIG=opentitan
         ```
      - To run CSR Test:
         ```bash
         cd ibex
         make build-csr-test run-csr-test IBEX_CONFIG=opentitan
         ```
