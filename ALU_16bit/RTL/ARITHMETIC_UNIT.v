module ARITHMETIC_UNIT 
#( parameter IN_DATA_WIDTH  = 16,
             OUT_DATA_WIDTH = 32 )
(
  input                               CLK , RST ,
  input [IN_DATA_WIDTH - 1 : 0]       A , B ,
  input [1:0]                         ALU_FUNC ,
  input                               Arith_Enable ,
  output reg [OUT_DATA_WIDTH-1 : 0]   Arith_OUT ,
  output reg Carry_OUT , 
  output reg Arith_Flag
  );
  
  reg [OUT_DATA_WIDTH-1 : 0] Arith_OUT_comb ;
  wire Carry_OUT_comb ;
  reg Arith_Flag_comb ;
  
  always@(posedge CLK or negedge RST)
  begin
    if (~RST) begin
      Arith_OUT <= 'b0 ;
      Carry_OUT <= 1'b0 ;
      Arith_Flag <= 1'b0 ;
       end
   else begin
      Arith_OUT  <= Arith_OUT_comb ;
      Carry_OUT  <= Carry_OUT_comb ;
      Arith_Flag <= Arith_Flag_comb ;
    end
  end
  
  always@*
  begin
    
    Arith_OUT_comb  = 'b0 ;
    Arith_Flag_comb = 1'b0 ;

  if (Arith_Enable)
    case(ALU_FUNC)
      2'b00 : begin
              Arith_OUT_comb = A + B ;
              Arith_Flag_comb = 1'b1 ;              
		      end
      2'b01 : begin
              Arith_OUT_comb = A - B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      2'b10 : begin
              Arith_OUT_comb = A * B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      2'b11 : begin
              Arith_OUT_comb = A / B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      endcase
      
  else begin
    Arith_OUT_comb = 'b0 ;
    Arith_Flag_comb = 1'b0 ;
  end
  end
  
assign Carry_OUT_comb = Arith_OUT_comb [IN_DATA_WIDTH] ;

endmodule