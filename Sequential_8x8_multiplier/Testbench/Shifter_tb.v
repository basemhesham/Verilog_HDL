`timescale 1ns / 1ps

module Shifter_tb();
reg [1:0] shift_cntrl ;
reg [7:0] inp ;
wire [15:0] shift_out ;

Shifter uut (
 .inp(inp) ,
 .shift_cntrl(shift_cntrl) ,
 .shift_out(shift_out)
);

initial 
begin
shift_cntrl = 2'b00 ;
inp = 8'b01001111 ;
end

always
begin
#100
shift_cntrl = 2'b01 ;
#100
shift_cntrl = 2'b10 ;
#100
shift_cntrl = 2'b11 ;
#100 $stop ;
end

endmodule

