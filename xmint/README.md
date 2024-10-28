# XMint | RISC-V32 Single Cycle Core Design

## **1. Introduction**

The XMint project implements a RISC-V32 single-cycle core using Verilog. This document provides a comprehensive overview of the design architecture, detailing the datapath and the core components involved in the implementation.

## **2. Design Overview**

### **2.1 Architecture**

The XMint core is designed as a single-cycle processor, where each instruction is executed within a single clock cycle. This design approach simplifies control logic and lays the groundwork for potential pipelining in future revisions, enhancing performance.

### **2.2 Core Components**

The architecture comprises the following key components:

- **Instruction Memory (IMEM)**: Stores the instructions to be executed by the CPU.
- **Program Counter (PC)**: Tracks the address of the next instruction to be executed.
- **Adder**: Performs arithmetic operations, particularly addition.
- **Register File**: Stores data operands for instructions and facilitates reading and writing of register values.
- **ALU**: Executes arithmetic and logical operations on the data.
- **Data Memory (DMEM)**: Stores data that the CPU accesses during instruction execution.
- **Immediate Generation (ImmGen)**: Generates immediate values used in various instructions.

#### **2.2.1 Instruction Memory (IMEM)**

The Instruction Memory (IMEM) is critical for holding the instructions that the CPU will process.

<img src="design/InstructionMemory.png" alt="Instruction Memory" width="400" height="auto">

#### **2.2.2 Program Counter (PC)**

The Program Counter (PC) is a crucial component that holds the address of the next instruction to be fetched from memory. It increments with each clock cycle, ensuring the sequential execution of instructions unless a branch or jump instruction modifies its value.

<img src="design/PC.png" alt="Program Counter" width="400" height="auto">

#### **2.2.3 Adder**

The Adder is a fundamental component in the XMint core, responsible for performing arithmetic addition. It is used primarily in two contexts:

1. **PC Increment**: The Adder adds a constant value (typically 4) to the current value of the Program Counter (PC) to fetch the next instruction sequentially.
2. **Branch Address Calculation**: When a branch instruction is executed, the Adder computes the target address by adding an offset to the current PC value.

This functionality is crucial for the correct operation of the control flow within the processor.

<img src="design/Adder.png" alt="Adder" width="400" height="auto">

#### **2.2.4 Register File**

The Register File is a vital component of the XMint core, responsible for storing and managing the CPU's registers. Key features include:

- **Storage Capacity**: The Register File typically contains 32 registers (x0 to x31) that can store 32-bit values.
- **Read and Write Operations**: It supports simultaneous read and write operations, allowing the CPU to access data quickly during instruction execution.
- **Zero Register**: The zero register (x0) is hardwired to zero, providing a constant value for operations that require a zero input.

The Register File plays a crucial role in executing instructions by supplying operands to the ALU and storing results.

<img src="design/RegisterFile.png" alt="Register File" width="400" height="auto">

#### **2.2.5 ALU**

The Arithmetic Logic Unit (ALU) is a critical component of the XMint core, responsible for performing a variety of arithmetic and logical operations. Key features of the ALU include:

- **Arithmetic Operations**: The ALU can perform basic arithmetic operations such as addition, subtraction, multiplication, and division. In the context of RISC-V32, it primarily supports addition and subtraction.

- **Logical Operations**: It can execute logical operations like AND, OR, NOT, and XOR, essential for manipulating binary data and implementing conditional operations.

- **Input Selection**: The ALU receives its inputs from the Register File, allowing it to operate on the values stored in the CPU's registers.

- **Output**: The result of the ALU's computation is sent back to the Register File or to data memory, depending on the instruction type.

The ALU is essential for executing instructions that require data manipulation and plays a crucial role in the overall functionality of the core.

<img src="design/ALU.png" alt="ALU" width="400" height="auto">

#### **2.2.6 Data Memory (DMEM)**

Data Memory (DMEM) is a vital component of the XMint core, responsible for storing data that the CPU needs to access during instruction execution. Key features of DMEM include:

- **Storage Capability**: DMEM typically supports a range of addresses, allowing it to store a significant amount of data (e.g., 32-bit words).

- **Read and Write Operations**: The Data Memory supports both read and write operations, enabling the CPU to fetch data from memory and store results back into memory as needed.

- **Load and Store Instructions**: DMEM interacts closely with load (LW) and store (SW) instructions, which are essential for transferring data between the CPU and memory.

The Data Memory component is crucial for maintaining the state of programs and providing the necessary data for computation.

<img src="design/DataMemory.png" alt="Data Memory" width="400" height="auto">

#### **2.2.7 Immediate Generation (ImmGen)**

The Immediate Generation unit (ImmGen) is essential for producing immediate values used in various instructions. Key features of ImmGen include:

- **Immediate Value Extraction**: ImmGen extracts immediate values from the instruction encoding. These values are often used in arithmetic operations, branch instructions, and loading data.

- **Sign Extension**: The unit performs sign extension to ensure that the immediate value has the correct sign when it is used in operations. This is particularly important for operations like subtraction, where negative values are involved.

- **Support for Different Formats**: ImmGen supports multiple instruction formats (e.g., I-type, S-type) to generate the appropriate immediate values based on the type of instruction being executed.

The Immediate Generation unit enhances the flexibility of the processor by enabling it to handle a wide range of instructions that require immediate data.

<img src="design/ImmediateGeneration.png" alt="Immediate Generation" width="400" height="auto">

## **3. Datapath**

The datapath integrates all components, facilitating the flow of data during instruction execution. It is divided into several parts to handle different operations efficiently. Below is the diagram and description for the Instruction Fetch operation.

### **3.1 Datapath for Instruction Fetch**

The Instruction Fetch datapath is responsible for retrieving the next instruction from memory based on the address provided by the Program Counter (PC). During this operation, the following steps occur:

1. The Program Counter (PC) provides the address of the instruction to the Instruction Memory (IMEM).
2. The IMEM retrieves the instruction stored at that address.
3. The PC is incremented to point to the next instruction, preparing for the upcoming fetch cycle.

<img src="design/Datapath_InstructionFetch.png" alt="Datapath for Instruction Fetch" width="800" height="auto">

## **4. Conclusion**

The XMint project effectively demonstrates the implementation of a RISC-V32 single-cycle core using Verilog. The modular design not only allows for straightforward expansion and testing of individual components but also serves as a foundation for future enhancements, including performance optimizations and the potential introduction of pipelining.

## **5. References**

- **Computer Organization and Design - RISC-V Edition: The Hardware/Software Interface**