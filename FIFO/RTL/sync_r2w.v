`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2023 10:56:29
// Design Name: 
// Module Name: sync_r2w
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


module sync_r2w #(parameter ADDRSIZE = 4)
(output reg [ADDRSIZE:0] wq2_rptr,
input      [ADDRSIZE:0] rptr,
input                   wclk, wrst_n);

reg [ADDRSIZE:0] wq1_rptr;

always @(posedge wclk or negedge wrst_n)
if (!wrst_n) {wq2_rptr,wq1_rptr} <= 0;
else         {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};
endmodule

