`timescale 1ns / 1ps

module Adder_tb( );
reg [15:0] shift_out ;
reg [15:0] product8x8_out ;
wire [15:0] sum ;

Adder uut (
.shift_out(shift_out) ,
.product8x8_out(product8x8_out) ,
.sum(sum)
);
initial 
begin
shift_out = 16'd6 ;
product8x8_out = 16'd14 ;
end

always
begin
#50 
shift_out = 16'd5 ;
product8x8_out = 16'd10 ;

#50 
shift_out = 16'd100 ;
product8x8_out = 16'd40 ;

#50 
shift_out = 16'd0 ;
product8x8_out = 16'd20 ;

#50 $stop ;
end
endmodule


