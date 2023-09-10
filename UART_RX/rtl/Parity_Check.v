module UART_RX_Parity_check(
  input PAR_TYP,
  input par_chk_en, sampled_bit,
  input [7:0] P_DATA,
  input CLK, RST,
  output reg par_err
);
  
  
  always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      par_err <= 1'b0;
    
    else if (par_chk_en)
      begin
        case (PAR_TYP)
          //Even parity
          1'b0: begin
                  if (sampled_bit == ^P_DATA)
                      par_err <= 1'b0;
                    
                  else par_err <= 1'b1;
                end
          //Odd parity
          1'b1: begin
                  if (sampled_bit == ~(^P_DATA))
                      par_err <= 1'b0;
                    
                  else par_err <= 1'b1;
                end 
          
          default: par_err <= 1'b1;
        endcase
      end
    
    else par_err <= 1'b1;
  end
  
endmodule