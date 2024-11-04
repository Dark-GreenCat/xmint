# XMint | RISC-V Processor on FPGA | Digital Design 2023 Course

## **1. Overview**

This project implements a RISC-V processor using Verilog, aimed at providing a hands-on experience in digital design and FPGA development. The design focuses on the RISC-V architecture, demonstrating fundamental concepts in computer architecture, digital logic, and hardware description languages.

## **2. Features**

- **RISC-V Architecture**: Supports a subset of the RISC-V instruction set.
- **FPGA Implementation**: Designed for synthesis on FPGA platforms.
- **Modular Design**: Components are structured for easy modification and expansion.
- **Simulation and Testing**: Includes testbenches for verifying functionality.

## **3. Getting Started**

### **3.1. Prerequisites**

- A compatible FPGA development board (e.g., Xilinx, Intel/Altera)
- Verilog simulation tools (e.g., QuestaSim, Vivado)
- Synthesis tools (e.g., Quartus, Vivado)

### **3.2. Installation**

**Step 1. Clone the repository:**
   ```bash
   git clone https://github.com/Dark-GreenCat/xmint.git
   cd xmint
   ```

**Step 2. Install Ibex's environment:**
   ```bash
   make install-ibex
   ```

   - Follow the Makefile in the Ibex repository for more useful commands. For example:
      - To run Simple System:
         ```bash
         make -C ibex/ sw-simple-hello build-simple-system run-simple-system IBEX_CONFIG=opentitan
         ```
      - To run CSR Test:
         ```bash
         make -C ibex/ build-csr-test run-csr-test IBEX_CONFIG=opentitan
         ```
   **List of `IBEX_CONFIG` values can be seen in [ibex/ibex_configs.yaml](ibex/ibex_configs.yaml)**

**Step 3. Source the Configuration**

Run the following command to set up your environment:

```bash
source config.sh
```

The script `config.sh` will provide the following variables:

| Variable                          | Description                                         | Available after command                                      |
|-----------------------------------|-----------------------------------------------------|--------------------------------------------------------------|
| **`XMINT_REPO_BASE`**             | Root directory of the XMint repository              | —                                                            |
| **`IBEX_REPO_BASE`**              | Root directory of the Ibex repository               | `make install-ibex`                                          |
| **`RISCV_COMPLIANCE_REPO_BASE`**  | Root directory of the RISC-V Compliance repository  | `make install-riscv-compliance`                              |
| **`Vibex_simple_system`**         | Simulator for the Ibex Simple System                | `make -C ibex/ build-simple-system IBEX_CONFIG=opentitan`    |
| **`Vibex_riscv_compliance`**      | Simulator for RISC-V Compliance                     | `make -C ibex/ build-riscv-compliance IBEX_CONFIG=opentitan` |
| **`Vtb_cs_registers`**            | Simulator for the Ibex CSR Test                     | `make -C ibex/ build-csr-test IBEX_CONFIG=opentitan`         |


**Step 4. Integrate XMint to Ibex's Environment**

- **Step 4.1. Integrate XMint to Ibex**

Run the following command to install XMint into the Ibex environment:

```bash
make integrate-xmint-to-ibex
```

Now you can execute any command from Ibex for XMint. For example, the command below will build the simulation with XMint's core and then run the simulation:

```bash
make -C ibex/ sw-simple-hello build-simple-system run-simple-system
```

- **Step 4.2. (Optional) Uninstall XMint from Ibex**

If you need to uninstall XMint from Ibex, use the following command:

```bash
make uninstall-xmint-from-ibex
```

## **4. Optional Tasks**

> **Note:** These operations require you to run `source config.sh` from the XMint root repository first.

### **4.1. RISC-V Compliance Test**

Verify the correctness of your implementation against the RISC-V specification by running the RISC-V compliance test. Follow these steps:

**1. Clone the RISC-V Compliance Repository**:

   Navigate to the XMint repository and install the RISC-V compliance tools:
   ```bash
   cd $XMINT_REPO_BASE
   make install-riscv-compliance
   ```

   This will create a configuration script named `config-riscv-compliance.sh`. You can modify this script based on the file [riscv-compliance/Makefile.include](riscv-compliance/Makefile.include) provided in the RISC-V Compliance repository.
   Note that `source config-riscv-compliance.sh` will overide the default value provided by RISC-V Compliance

**2. Build the RISC-V Compliance Simulator**:
   ```bash
   make -C ibex/ build-riscv-compliance IBEX_CONFIG=opentitan
   ```

**3. Run the Compliance Test**:

   Source the configuration script and execute the compliance test:
   ```bash
   source config-riscv-compliance.sh
   make -C riscv-compliance/ clean build run verify
   ```

**4. View the Results**:

   After running the test, check the output logs for compliance results. Look for any assertions or errors that may indicate areas needing attention.
