`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2023 17:54:04
// Design Name: 
// Module Name: mux4
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



module mux4 (
input [7 : 0] dataa ,
input [7 : 0] datab ,
input [1 : 0] sel,
output reg [3:0] aout ,
output reg [3:0] bout
);
  always@(dataa ,sel[1])
   begin
     aout =8'd0 ;
     case(sel[1])
       1'b0 : aout = dataa[3 : 0] ;
       1'b1 : aout = dataa[7 : 4] ;
       default : aout =8'd0 ;
     endcase
   end
always@(datab , sel[0])
   begin
     bout =8'd0 ;
     case(sel[0])
       1'b0 : bout = datab[3 : 0] ;
       1'b1 : bout = datab[7 : 4] ;
       default : bout = 8'd0 ;
   endcase
 end
endmodule

