`timescale 1ns / 1ps

module Shifter(
 input [1:0] shift_cntrl ,
 input [7:0] inp ,
 output reg [15:0] shift_out 
    );
    
  always @(*)
    begin
    case(shift_cntrl)
      2'b00 : shift_out = {8'd0 , inp} ;  // no shift 
      2'b01 : shift_out = {4'd0 , inp ,4'd0} ;  // 4-bit left shift 
      2'b10 : shift_out = {inp , 8'd0} ;     //8-bit left shift
      2'b11 : shift_out = {8'd0 , inp} ;  // no shift 
      default : shift_out= 16'bx ;
    endcase
     
    end
    
endmodule

