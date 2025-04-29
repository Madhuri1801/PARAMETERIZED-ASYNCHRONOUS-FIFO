`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 04:07:09 PM
// Design Name: 
// Module Name: fifo_mem
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


module fifomem
#(
  parameter DATASIZE = 8, 
  parameter ADDRSIZE = 3'b100  
)
(
  input   wclken, wfull, wclk,rempty,rclk,rclken,
  input   [ADDRSIZE-1:0] waddr, raddr,
  input   [DATASIZE-1:0] wdata,
  output reg  [DATASIZE-1:0] rdata
);

  localparam DEPTH = 1<<(ADDRSIZE);
  initial
  $display("DEPTH IS %d", DEPTH);

  reg [DATASIZE-1:0] mem [0:DEPTH-1];



  always @(posedge wclk)
    if (wclken && !wfull)
      mem[waddr] <= wdata;
    
    always @(posedge rclk)
    if (rclken && !rempty)
      rdata <= mem[raddr];
endmodule