`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 11:31:41
// Design Name: 
// Module Name: zig_zag_traversal
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


module zig_zag_traversal (
    input clk,
    input reset,
    output reg done,
    input [5:0] ram_read_addr,       
    output [7:0] ram_read_data       
);

  
  wire [7:0] rom_data;
  reg [5:0] rom_addr;        
  reg [5:0] ram_write_addr;   

  
  Rom rom_inst (
    .addr(rom_addr),
    .data(rom_data)
  );

  
  reg [7:0] ram [0:63];
  assign ram_read_data = ram[ram_read_addr]; 

  
  
  
  reg [3:0] diag;
  reg [3:0] r;      

  
  parameter S_INIT    = 2'b00;
  parameter S_PROCESS = 2'b01;
  parameter S_DONE    = 2'b10;

  reg [1:0] state;

  
  reg [3:0] r_min;
  reg [3:0] r_max;

  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      
      state           <= S_INIT;
      diag            <= 0;
      ram_write_addr  <= 0;
      done            <= 0;
    end else begin
      case (state)
        S_INIT: begin
          if (diag < 8) begin
            r_min <= 0;
            r_max <= diag;
          end else begin
            r_min <= diag - 7;
            r_max <= 7;
          end

          if (diag[0] == 1) begin
            r <= r_max;
          end else begin
            r <= r_min;
          end

          state <= S_PROCESS;
        end

        S_PROCESS: begin
          rom_addr <= r * 8 + (diag - r);
          ram[ram_write_addr] <= rom_data;
          ram_write_addr <= ram_write_addr + 1;

          if (diag[0] == 1) begin
            if (r > r_min) begin
              r <= r - 1;
            end else begin
              if (diag < 14) begin
                diag <= diag + 1;
                state <= S_INIT;
              end else begin
                state <= S_DONE;
              end
            end
          end else begin
            if (r < r_max) begin
              r <= r + 1;
            end else begin
              if (diag < 14) begin
                diag <= diag + 1;
                state <= S_INIT;
              end else begin
                state <= S_DONE;
              end
            end
          end
        end

        S_DONE: begin
          done <= 1;
        end

        default: state <= S_INIT;
      endcase
    end
  end

endmodule


