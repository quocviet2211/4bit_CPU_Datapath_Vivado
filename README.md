# 4-Bit RISC CPU Design Using Verilog
<img width="604" height="320" alt="Screenshot 2026-10-15 174317" src="https://github.com/user-attachments/assets/5c043f68-09d5-4ef3-8c02-219228536c9f" />

## 1. Project Overview

This project implements a 4-bit RISC CPU using Verilog HDL. The processor uses a 3-stage pipeline:

- IF (Instruction Fetch)
- ID (Instruction Decode)
- EX (Execute)

The design includes a program counter, instruction memory, control unit, register file, ALU, data memory, pipeline registers, and status flags.

## 2. Architecture

The CPU follows a modular design. The program counter selects the instruction address, instruction memory provides the instruction, the control unit decodes it, and the ALU performs the required operation.

The pipeline allows different instructions to occupy different processing stages during the same clock cycle.

## 3. Main Components

- Program Counter (PC)
- Instruction Memory
- Instruction Decoder
- Control Unit
- Register File
- Arithmetic Logic Unit (ALU)
- Data Memory
- Pipeline Registers
- Flag Register
- Branch and Jump Control

## 4. Project Structure

- `src/`: CPU modules written in Verilog
- `testbench/`: CPU verification testbench
- `programs/`: Memory initialization files
- `docs/`: Architecture diagrams and simulation results

## 5. Verification

The CPU is tested with several programs:

- `program.mem`: Demonstration program
- `prog_arith.mem`: Arithmetic operations
- `prog_logic.mem`: Logic operations
- `prog_jump.mem`: Jump instructions

The testbench checks instruction execution, register values, program counter behavior, and pipeline operation.

## 6. Tools

- Verilog HDL
- Xilinx Vivado
- Behavioral Simulation

## 7. Learning Outcomes

- RISC CPU architecture
- Instruction decoding and control signals
- Datapath design
- Three-stage pipelining
- Verilog testbench development
- Functional verification

## 8. Author

Designed as an academic computer architecture project.
