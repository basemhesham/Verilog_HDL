`timescale 1ns / 1ps

module multiplier4x4(
input [7 : 0] dataa ,
input [7 : 0] datab ,
input [1 : 0] sel,
output reg [7 : 0] product
    );
    
    wire [3 : 0] aout , bout ;
    
    mux4 m1(
     .dataa(dataa),
     .datab(datab),
     .sel(sel),
     .aout(aout),
     .bout(bout)
    );
    
     always @ (*) begin
        product =  aout * bout ;
    end
    
endmodule

