`timescale 1ns / 1ps

module Register(
input clk , sclr_n , clk_ena ,
input [15:0] datain ,
output reg [15:0] reg_out
    );
  
always @(posedge clk) 
  begin
  case({clk_ena , sclr_n})
  2'b10 : reg_out <= 16'b0 ;
  2'b11 : reg_out <= datain ;
  default :  reg_out <= reg_out ;
  endcase
  
    end
    
 endmodule










