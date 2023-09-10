`timescale 1ns / 1ps

module Counter(
 input clk , aclr_n ,
 output reg [1:0] count_out
    );
    
    always @(posedge clk ,negedge aclr_n)
    begin
      if (~aclr_n)
         count_out <= 2'b00 ;
      else 
         count_out <= count_out + 1 ;
    end
    
endmodule


