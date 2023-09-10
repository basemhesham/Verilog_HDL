`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2023 12:57:15
// Design Name: 
// Module Name: Stop_Check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Stop_Check(
  input          stop_chk_en, 
  input          sampled_bit,
  input          CLK, RST,
  output reg     stp_err
  );
    
    always@(posedge CLK or negedge RST)
      begin
         if(~RST)
             stp_err <= 1'b0 ;
          else if (stop_chk_en) begin
             if(sampled_bit == 1'b1 )
               stp_err <= 1'b0 ;
             else
              stp_err <= 1'b1 ;
          end
        else 
        stp_err <= 1'b1;
      end
    
endmodule

