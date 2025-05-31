# Verilog-Based-Zig-Zag-Matrix-Scanner

A hardware design in Verilog that performs zig-zag traversal on an 8×8 matrix. The matrix is stored in a ROM, and values are read diagonally (zig-zag order) and written sequentially into a RAM. This project demonstrates RTL design and functional simulation

In image and video compression (e.g., JPEG, MPEG), zig-zag traversal is used to convert a 2D block of coefficients into a 1D sequence that clusters low-frequency values first. This repository implements an 8×8 zig-zag scanner in Verilog:

1.ROM Module (rom8x8.v)
Stores an 8×8 matrix in row-major order (64 words × 8 bits).

2.Zig-Zag Controller (zig_zag_traversal.v)
 A finite-state machine (FSM) that:
   ->Computes diagonal boundaries,
   ->Alternates traversal direction based on diagonal parity,
   -> Maps 2D indices → 1D addresses to read ROM values,
   ->Writes data sequentially into RAM,
   ->Provides an external read interface for verification.

3.Testbench (zig_zag_traversal_tb.v)
Simulates the design, generates clock/reset, waits for completion, and outputs RAM contents to verify correct zig-zag ordering.

