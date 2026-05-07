# ECE 465 Graduate Project - Joseph Latocha
## Adder Architecture Comparison Using Verilog Simulation

### Author
Joseph Latocha

### Project Description
This project compares three adder architectures in terms of:
- Hardware Complexity
- Simulation Timing (clock cycles required for completion)
- Verilog Coding Complexity

The following adders were implemented and simulated:
- Ripple Carry Adder (RCA)
- Carry Look-Ahead Adder (CLA)
- Sklansky Parallel Prefix Adder (PP)

### Tools Used
- Verilog
- Verilator
- GTKWave
- Ubuntu WSL
- VS Code

### Files Included
- CLA_4.v
- CLA_4_Clock.v
- CLA_32.v
- FA.v
- PP_16.v
- Ripple_Carry_32.v
- Test_CLA_4.v
- Test_CLA_32.v
- Test_FA.v
- Test_PP_16.v
- Test_Ripple_32.v
- sim_main.cpp
- Graduate Seed Presentation-Joseph Latocha.ppt

### Running the Simulation
 Note the sim_main.cpp file must be revised to accurately refer to the testbench for the appropriate adder architecture. The sim_main.cpp is currently setup for operation with the parallel prefix adder testbench. Example Verilator, .cpp file creation, and GTKWave file creation commands in Ubuntu WSL:


```bash
verilator -Wall --trace --timing --cc PP_16.v Test_PP_16.v --top-module Test_PP_16 --exe sim_main.cpp

make -C obj_dir -f VTest_PP_16.mk

./obj_dir/VTest_FullAdd

gtkwave Test_PP_16.vcd

