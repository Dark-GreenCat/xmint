# XMint | RISC-V32 Single Cycle Core Design

## **1. Introduction**

The XMint project implements a RISC-V32 single cycle core using Verilog. This document details the design architecture, including the datapath and component descriptions.

## **2. Design Overview**

### **2.1 Architecture**

The XMint core is designed as a single-cycle processor, meaning that each instruction is executed in a single clock cycle. This design simplifies control logic and sets the foundation for potential pipelining in future revisions.

### **2.2 Components**

The core consists of the following main components:

- **Instruction Memory (IMEM)**
- **Register File**
- **ALU (Arithmetic Logic Unit)**
- **Data Memory**
- **Control Unit**

#### **2.2.1 Instruction Memory (IMEM)**

The IMEM holds the instructions for CPU.

<img src="design/InstructionMemory.png" alt="Instruction Memory" width="400" height="auto">

#### **2.2.2 Register File**

The register file stores data and supports operations for reading and writing to 32 registers.

![Register File](path/to/register_file_image.png)

#### **2.2.3 ALU (Arithmetic Logic Unit)**

The ALU performs arithmetic and logical operations, processing inputs from the register file and generating outputs.

![ALU](path/to/alu_image.png)

#### **2.2.4 Data Memory**

Data memory is utilized for storing variables and supports read and write operations.

![Data Memory](path/to/data_memory_image.png)

#### **2.2.5 Control Unit**

The control unit generates signals based on the opcode of the fetched instruction, directing the operation of other components.

![Control Unit](path/to/control_unit_image.png)

## **3. Datapath**

The datapath integrates all components, facilitating data flow during instruction execution. Below is a simplified diagram of the datapath for the XMint core.

![Datapath Diagram](path/to/datapath_image.png)

## **4. Conclusion**

The XMint project showcases the implementation of a RISC-V32 single cycle core using Verilog. The modular design enables easy expansion and testing of individual components. Future enhancements may include performance optimizations and the introduction of pipelining.

## **5. References**

- Computer Organization and Design - RISC-V Edition: The Hardware/Software Interface