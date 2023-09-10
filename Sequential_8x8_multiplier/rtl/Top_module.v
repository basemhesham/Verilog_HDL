`timescale 1ns / 1ps

module Top_module(
 input [7:0] dataa ,
 input [7:0] datab ,
 input clk ,
 input reset_a ,
 input start ,
 output done ,
 output [15:0] product8x8_out ,
 output seg_a , seg_b , seg_c , seg_d , seg_e , seg_f , seg_g 
    );
    
    wire [1:0] sel ;
    wire [1:0] shift ;
    wire [2:0] state_out ;
    wire clk_ena , sclr_n ;
    wire [1:0] count_out ;
    wire bout , aout ;
    wire [15:0] shift_out ;
    wire [15:0] sum ;
    wire [7:0] product ;
    
    Counter two_bit_counter (
    .clk(clk),
    .aclr_n(~start),
    .count_out(count_out)
    );
    
      multiplier4x4 multiplier_4x4 (
      .dataa(dataa),
      .datab(datab) ,
      .sel(sel) ,
      .product(product)
      );
      
    mult_control multiliier_control (
    .clk(clk) ,
    .reset_a(reset_a),
    .start(start) ,
    .count(count_out),
     .done(done),
     .clk_ena(clk_ena),
     .sclr_n(sclr_n),
      .state_out(state_out),
      .input_sel(sel),
      .shift_sel(shift)  
    );
    
  
    Shifter shifter (
     .inp(product) ,
     .shift_cntrl(shift) ,
     .shift_out(shift_out)
    );
    
    Adder Adder_16bit  (
    .shift_out(shift_out) ,
    .product8x8_out(product8x8_out) ,
    .sum(sum)
    );
    
    Register Register_16bit (
    .clk(clk) ,
    .sclr_n(sclr_n) ,
    .clk_ena(clk_ena) ,
    .datain(sum) ,
    .reg_out(product8x8_out)
    );
    
    seven_segment_decoder decoder(
        .inp(state_out),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_f(seg_f),
        .seg_g(seg_g)
    );
    
endmodule

