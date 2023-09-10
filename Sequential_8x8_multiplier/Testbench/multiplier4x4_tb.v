`timescale 1ns / 1ps

module multiplier4x4_tb();
reg [7 : 0] dataa ;
reg [7 : 0] datab ;
reg [1 : 0] sel;
wire [7 : 0] product ;

multiplier4x4 uut (
.dataa(dataa),
.datab(datab) ,
.sel(sel) ,
.product(product)
);
//timer
initial 
#200 $stop ;

initial 
begin
dataa = 8'b00111100 ;
datab = 8'b11001110 ;
sel = 2'b00 ;
#50 

sel = 2'b01 ;
#50

sel = 2'b10 ;
#50

sel = 2'b11 ;
end
endmodule

