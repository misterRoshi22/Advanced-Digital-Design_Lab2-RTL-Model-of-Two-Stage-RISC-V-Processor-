# Lab2_RTL-Model-of-Two-Stage-RISC-V-Processor
## RTL Model of a Two-Stage Pipelined RISC-V-v2 Processor

- Register x0 always equals 0.
- On reset, register sp (x2) will be set to 1024.
- Supports static branch prediction, always assuming not taken.
- Branch misprediction leads to a 1-cycle delay.
- On branch misprediction, REG gets flushed.
- Branch instructions utilize the ALU, using SUB, SLT, SLTU.
- Data Memory: 2Kx8 Bits
- Instruction Memory: 2Kx8 Bits





# Control Signals
| **Instruction** | **OpCode** | **ALUOp** | **RegWrite** | **ALUSrc** | **MemRead** | **MemWrite** | **MemToReg** | **Branch** | **Jump** |
| ----------- | ------- | ----- | -------- | ------ | ------- | -------- | -------- | ------ | ---- |
| ADDI        | 0010011 | 0000  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| SLLI        | 0010011 | 00001 | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| SLTI        | 0010011 | 0010  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| SLTIU       | 0010011 | 0011  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| XORI        | 0010011 | 0100  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| SRLI        | 0010011 | 0101  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| ORI         | 0010011 | 0110  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| ANDI        | 0010011 | 0111  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| ADD         | 0110011 | 0000  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| SUB         | 0110011 | 1000  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| SLL         | 0110011 | 0001  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| STL         | 0110011 | 0010  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| SLTU        | 0110011 | 0011  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| XOR         | 0110011 | 0100  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| SRL         | 0110011 | 0101  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| OR          | 0110011 | 0110  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| AND         | 0110011 | 0111  | 1        | 0      | 0       | 0        | 00       | 0000   | 00   |
| LUI         | 0110111 | 1001  | 1        | 1      | 0       | 0        | 00       | 0000   | 00   |
| J           | 1100111 | XXXX  | 0        | X      | 0       | 0        | XX       | 0000   | 01   |
| JAL         | 1101111 | XXXX  | 0        | X      | 0       | 0        | 10       | 0000   | 10   |
| JALR        | 1101011 | XXXX  | 0        | X      | 0       | 0        | 10       | 0000   | 10   |
| BEQ         | 1100011 | 1000  | 0        | 1      | 0       | 0        | XX       | 1000   | 00   |
| BNQ         | 1100011 | 1000  | 0        | 1      | 0       | 0        | XX       | 1001   | 00   |
| BLT         | 1100011 | 0010  | 0        | 1      | 0       | 0        | XX       | 1100   | 00   |
| BGE         | 1100011 | 0010  | 0        | 1      | 0       | 0        | XX       | 1101   | 00   |
| BLTU        | 1100011 | 0011  | 0        | 1      | 0       | 0        | XX       | 1110   | 00   |
| BGEU        | 1100011 | 0011  | 0        | 1      | 0       | 0        | XX       | 1111   | 00   |
| LW          | 0000011 | 0000  | 1        | 1      | 1       | 0        | 01       | 0000   | 00   |
| SW          | 0100011 | 0000  | 0        | 1      | 0       | 1        | XX       | 0000   | 00   |

# ALU Operations
| **ALUOp** | **Operation** |
| ----- | --------- |
| 0000  | ADD       |
| 0001  | SLL       |
| 0010  | SLT       |
| 0011  | SLTU      |
| 0100  | XOR       |
| 0101  | SRL       |
| 0110  | OR        |
| 0111  | AND       |
| 1000  | SUB       |
| 1001  | LUI       |
