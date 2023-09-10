`timescale 1ns / 1ps

module Adder(

input [15:0] shift_out ,
input [15:0] product8x8_out,
output [15:0] sum 

    );
    
    assign sum = product8x8_out + shift_out ;
    
endmodule


