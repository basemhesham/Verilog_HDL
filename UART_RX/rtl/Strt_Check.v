module Strt_Check(
  input          strt_chk_en, 
  input          sampled_bit,
  input          CLK, RST,
  output reg     strt_glitch
  );
    
    always@(posedge CLK or negedge RST)
      begin
         if(~RST)
             strt_glitch <= 1'b0 ;
          else if (strt_chk_en) begin
             if(sampled_bit == 1'b0 )
               strt_glitch <= 1'b0 ;
             else
              strt_glitch <= 1'b1 ;
          end
        else 
        strt_glitch <= 1'b1;
      end
    
endmodule
