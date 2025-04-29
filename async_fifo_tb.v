`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 04:14:50 PM
// Design Name: 
// Module Name: async_fifo_tb
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


module async_fifo_tb;

    parameter DSIZE = 8; 
    parameter ASIZE = 4; 
    parameter DEPTH = 1 << ASIZE; 

    reg [DSIZE-1:0] wdata;   
    wire [DSIZE-1:0] rdata; 
    wire wfull, rempty;     
    reg winc, rinc, wclk, rclk, wrst_n, rrst_n; 
    
    async_fifo1 #(DSIZE, ASIZE) fifo (
        .rdata(rdata), 
        .wdata(wdata),
        .wfull(wfull),
        .rempty(rempty),
        .winc(winc), 
        .rinc(rinc), 
        .wclk(wclk), 
        .rclk(rclk), 
        .wrst_n(wrst_n), 
        .rrst_n(rrst_n)
    );

    
    always #5 wclk = ~wclk;    
    always #10 rclk = ~rclk; 
    
    initial begin

        wclk = 0;
        rclk = 0;
        wrst_n = 1;
        rrst_n=1;
        #1 wrst_n=0;     
        rrst_n = 0;    
        winc = 0;
        rinc = 0;
     

   
        #40 wrst_n = 1;winc=1;rrst_n = 1 ;
            wdata = 23;
        #10 wdata=43;
        #10 wdata=42;
        #10 wdata=44;
        #10 wdata=45;
        #10 wdata=47;
        #10 wdata=1;
        #10 wdata=3;  
        #10 wdata=11; 
        #10 wdata=4;
        #10 wdata=54;
        #10 wdata=65;
        #10 wdata=77;
        #10 wdata=89;
        #10 wdata=99;  
        #10 wdata=121;
         #10 wdata=142;
        #10 wdata=44;
        #10 wdata=5;rinc=1;
        #10 wdata=7;
        #10 wdata=10;
        #10 wdata=13; 
        #10 wdata=11;
        winc=0;
         
            
      #1000  $finish;
    end

endmodule
