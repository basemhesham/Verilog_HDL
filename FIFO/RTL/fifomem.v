`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2023 09:46:36
// Design Name: 
// Module Name: fifomem
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


module fifomem #(parameter  DATASIZE = 8, // Memory data word width
parameter  ADDRSIZE = 4) // Number of mem address bits
(output [DATASIZE-1:0] rdata,
input  [DATASIZE-1:0] wdata,
input  [ADDRSIZE-1:0] waddr, raddr,
input                 wclken, wfull, wclk);

// RTL Verilog memory model
localparam DEPTH = 1<<ADDRSIZE;
reg [DATASIZE-1:0] mem [0:DEPTH-1];
assign rdata = mem[raddr];
always @(posedge wclk)
if (wclken && !wfull) mem[waddr] <= wdata;

endmodule

