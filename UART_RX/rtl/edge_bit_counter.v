module edge_bit_counter(
  input                CLK ,
  input                RST ,
  input                enable ,
  input      [4:0]     prescale ,
  output reg [4:0]     bit_cnt ,
  output reg [4:0]     edge_cnt
);
   reg    [4:0]        count ; 

   always @(posedge CLK or negedge RST) begin
      if (~RST) begin
         bit_cnt  <= 5'b0 ;   
         edge_cnt <= 5'b0 ;    
         count    <= 5'b0 ;    
      end
      else if (enable) begin
         case (prescale)
            5'd8: begin
               if (count == 5'b0111) begin      
                count <= 0 ;             
                 edge_cnt <= 0 ;            
                 bit_cnt <= bit_cnt + 1'b1 ; 
                 end
               else  begin
                  count <= count + 1'b1 ;             
                  edge_cnt <= edge_cnt + 1'b1 ;            
                  bit_cnt <= bit_cnt ;
               end  
            end
           5'd16: begin
               if (count == 5'b1111) begin      
                    count <= 0 ;             
                     edge_cnt <= 0 ;            
                     bit_cnt <= bit_cnt + 1'b1 ; 
                 end
                 else  begin
                      count <= count + 1'b1 ;             
                       edge_cnt <= edge_cnt + 1'b1 ;            
                       bit_cnt <= bit_cnt ;
                 end  
              end
            default: begin
               bit_cnt  <= 5'b0 ;          // Reset bit_cnt to 0 for any other prescale value
               edge_cnt <= 5'b0 ;          // Reset edge_cnt to 0 for any other prescale value
               count <= 0 ;                // Reset count to 0 for any other prescale value
            end
         endcase
      end
      else begin
         count    <= 0 ;    // Reset count to 0 if enable is false
         edge_cnt <= 0 ;    // Reset edge_cnt to 0 if enable is false
         bit_cnt  <= 0 ;    // Reset bit_cnt to 0 if enable is false
      end
   end

endmodule