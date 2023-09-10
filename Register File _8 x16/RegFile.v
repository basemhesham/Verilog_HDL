module RegFile #(parameter WIDTH = 16, DEPTH = 8, ADDR = 3 )
(
 input                      CLK , 
 input                      RST ,
 input      [ADDR-1 : 0]    Address ,
 input                      WrEn , 
 input                      RdEn ,
 input      [WIDTH-1 : 0]   WrData ,
 output reg [WIDTH-1 : 0]   RdData 
);
  
  integer I ;
  
  // register file of 8 registers each of 16 bits width
  reg [WIDTH-1:0] regArr [DEPTH-1:0] ;
   
 always @(posedge CLK or negedge RST)
 begin
   if(!RST)   
    begin
      for (I = 0 ; I < DEPTH ; I = I +1)
        begin
          regArr[I] <= 0 ;
        end
     end
   else if (WrEn && !RdEn) // Register Write Operation
     begin
      regArr[Address] <= WrData ;
     end
   else if (RdEn && !WrEn) // Register Read Operation
     begin    
       RdData <= regArr[Address] ;
     end        
  end

endmodule