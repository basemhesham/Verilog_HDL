`timescale 1ns / 1ps

module Register_tb();
reg clk , sclr_n , clk_ena ;
reg [15:0] datain ;
wire [15:0] reg_out ;

Register uut (
.clk(clk) ,
.sclr_n(sclr_n) ,
.clk_ena(clk_ena) ,
.datain(datain) ,
.reg_out(reg_out)
);

//clock
localparam T = 50 ;
always
begin
clk = 1'b1 ;
#(T/2) ;
clk = 1'b0 ;
#(T/2) ;
end

initial
begin
sclr_n = 1'b1 ;
clk_ena = 1'b1 ;
datain = 16'b0000111100001111 ;
end

always
begin
#100
sclr_n = 1'b0 ;
clk_ena = 1'b0 ;

#100
sclr_n = 1'b1 ;
clk_ena = 1'b0 ;

#100
sclr_n = 1'b0 ;
clk_ena = 1'b1 ;

#100
sclr_n = 1'b1 ;
clk_ena = 1'b1 ;

#100 $stop ;
end

endmodule
