`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 04:11:34 PM
// Design Name: 
// Module Name: async_fifo1
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


module async_fifo1
    #(
      parameter DSIZE = 8,
      parameter ASIZE = 4
     )
    (
      input   winc, wclk, wrst_n,
      input   rinc, rclk, rrst_n,
      input   [DSIZE-1:0] wdata,
    
      output  [DSIZE-1:0] rdata,
      output  wfull,
      output  rempty
    );
    
      wire [ASIZE-1:0] waddr, raddr;
      initial $display("ASIZE IS %d", ASIZE);
      
      wire [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
    
      sync_r2w sync_r2w (.wq2_rptr(wq2_rptr), .rptr(rptr), .wclk(wclk), .wrst_n(wrst_n));
      sync_w2r sync_w2r (.rq2_wptr(rq2_wptr), .wptr(wptr), .rclk(rclk), .rrst_n(rrst_n));
      fifomem #(DSIZE, ASIZE) fifomem (.rclken(rinc),.rempty(rempty),.rdata(rdata), .wdata(wdata), .waddr(waddr), .raddr(raddr), .wclken(winc), .wfull(wfull), .wclk(wclk),.rclk(rclk));
      rptr_empty #(ASIZE,DSIZE) rptr_empty (.rempty(rempty), .raddr(raddr), .rptr(rptr), .rq2_wptr(rq2_wptr), .rinc(rinc), .rclk(rclk), .rrst_n(rrst_n),.rdata(rdata));
      wptr_full #(ASIZE) wptr_full (.wfull(wfull), .waddr(waddr), .wptr(wptr), .wq2_rptr(wq2_rptr), .winc(winc), .wclk(wclk), .wrst_n(wrst_n));
    
    endmodule