# Synthesizable Square Root Circuit Design Implementation
## About the project
- VLSI Course Project on Logic Synthesis Design Constraints at CCU.
- The teaching professor : [Ching-Che Chung](https://www.cs.ccu.edu.tw/~wildwolf/)
## Implementation Details
- The implemented SQRT method in this project underwent pipeline optimization to meet the timing constraints of the circuit design, avoiding timing violations.
- The desired output for this lab is the square root of an unsigned integer, the input (IN) is a 16-bit unsigned integer (i.e. in the range of 16’h0000 ~ 16’hFFFF). 
- The required precision for output (OUT) is 12-bits, where 8-bit for integer part and 4-bit for fraction part.
### Logic-Synthesis_Design_Constaints
- Code suitable for logic synthesis tools like Design Compiler, leading to gate-level netlists.
- Synthesizable circuits in Verilog are designed in a way that can be automatically converted into hardware by synthesis tools, allowing them to be mapped onto programmable logic devices or ASICs.