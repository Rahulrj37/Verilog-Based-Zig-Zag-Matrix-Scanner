`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 11:30:26
// Design Name: 
// Module Name: Rom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Rom (
    input  [5:0] addr,    // 6-bit address to cover 64 locations (0-63)
    output [7:0] data     // 8-bit data output for each matrix element
);

  // Declare the ROM memory array (64 locations, each 8 bits wide)
  reg [7:0] memory [0:63];

  // Initialize the ROM with an 8x8 matrix in row-major order
  // For simplicity, each element is set to its corresponding index value.
  integer i;
  initial begin
    for (i = 0; i < 64; i = i + 1) begin
      memory[i] = i;   // matrix element (row, col) gets value (row*8 + col)
    end
  end

  // Combinationally output the value stored at the provided address
  assign data = memory[addr];

endmodule

