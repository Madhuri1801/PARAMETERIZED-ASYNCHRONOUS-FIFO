`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 03:59:46 PM
// Design Name: 
// Module Name: wptr_wfull
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


module wptr_full
#(
  parameter ADDRSIZE = 4
)
(
  input   winc, wclk, wrst_n,
  input   [ADDRSIZE :0] wq2_rptr,
  output reg  wfull,
  output  [ADDRSIZE-1:0] waddr,
  output reg [ADDRSIZE :0] wptr
);

  reg [ADDRSIZE:0] wbin;
  wire [ADDRSIZE:0] wgraynext, wbinnext;
  wire wfull_val;

  always @(posedge wclk or negedge wrst_n)
    if (!wrst_n)
      {wbin, wptr} <= 0;
    else begin
         wbin <= wbinnext;
         wptr<= wgraynext;
         end


  assign wbinnext = wbin + (winc & ~wfull);
  assign waddr = wbin[ADDRSIZE-1:0];
  assign wgraynext = (wbinnext>>1) ^ wbinnext;

  assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});

  always @(posedge wclk or negedge wrst_n)
    if (!wrst_n)
      wfull <= 1'b0;
    else
      wfull <= wfull_val;

endmodule
