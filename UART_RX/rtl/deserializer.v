module deserializer(
 input               deser_en ,
 input               sampled_bit ,
 input               CLK ,
 input               RST ,
 output reg  [7:0]   P_DATA
   );
    
     reg [3:0] counter;
     
     always@(posedge CLK or negedge RST)
     begin
       if(!RST)
         begin
           P_DATA <= 8'b0;
           counter <= 4'b0000;
         end
       
       else if(deser_en && counter != 4'b1000)
         begin
           P_DATA[counter] <= sampled_bit;
           counter <= counter + 1 ;        
         end
       
       else begin
             P_DATA <= 'b0;
             counter <= 4'b0000;
            end    
     end
     
   endmodule