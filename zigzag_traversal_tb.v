`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 12:37:29
// Design Name: 
// Module Name: zigzag_traversal_tb
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


module zigzag_traversal_tb;

  reg clk;
  reg reset;
  reg [5:0] ram_read_addr;
  wire [7:0] ram_read_data;
  wire done;

  zig_zag_traversal uut (
    .clk(clk),
    .reset(reset),
    .done(done),
    .ram_read_addr(ram_read_addr),
    .ram_read_data(ram_read_data)
  );

  always #5 clk = ~clk;

  integer i;

  initial begin
    clk = 0;
    reset = 1;
    ram_read_addr = 0;
    #20 reset = 0;

    wait(done);
    #10;

    
    for (i = 0; i < 64; i = i + 1) begin
      ram_read_addr = i;
      #10; 
    end

    #2000;
    $finish;
  end

endmodule








