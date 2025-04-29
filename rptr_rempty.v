`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2025 10:34:11 PM
// Design Name: 
// Module Name: rptr_rempty
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


module rptr_empty
#(
  parameter ADDRSIZE = 4,
  parameter DSIZE=8
)
(
  input   rinc, rclk, rrst_n,
  input   [ADDRSIZE :0] rq2_wptr,
  output  reg  rempty,
  output  [ADDRSIZE-1:0] raddr,
  output [DSIZE-1:0] rdata,
  output reg [ADDRSIZE :0] rptr
);

  reg [ADDRSIZE:0] rbin;
  wire [ADDRSIZE:0] rgraynext, rbinnext;
  wire rempty_val;


  always @(posedge rclk or negedge rrst_n)
    if (!rrst_n)
      {rbin, rptr} <= 0;
    else
      {rbin, rptr} <= {rbinnext, rgraynext};

  assign rbinnext = rbin + (rinc & ~rempty);
  assign raddr = rbin[ADDRSIZE-1:0];
  assign rgraynext = (rbinnext>>1) ^ rbinnext;

 
  assign rempty_val = (rgraynext == rq2_wptr);
  
  always @(posedge rclk or negedge rrst_n)
    if (!rrst_n)
      rempty <= 1'b1;
    else
      rempty <= rempty_val;

endmodule
