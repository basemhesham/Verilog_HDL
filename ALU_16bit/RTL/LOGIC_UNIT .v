module LOGIC_UNIT 

#( parameter IN_DATA_WIDTH  = 16 ,
             OUT_DATA_WIDTH = 16
)
(
input  wire [IN_DATA_WIDTH-1:0]  A   ,
input  wire [IN_DATA_WIDTH-1:0]  B   ,
input  wire [1:0]                ALU_FUNC ,
input  wire                      CLK ,
input  wire                      RST ,
input  wire                      Logic_Enable ,
output reg [OUT_DATA_WIDTH-1:0]  Logic_OUT,
output reg                       Logic_Flag
);

//internal signals
reg [OUT_DATA_WIDTH-1:0]  Logic_OUT_comb  ;
reg                       Logic_Flag_comb ;

//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (~RST)
     begin
      Logic_OUT  <= 'b0 ;
      Logic_Flag <= 'b0 ;	
	 end
   else
     begin   
      Logic_OUT  <= Logic_OUT_comb ;
      Logic_Flag <= Logic_Flag_comb ;
	 end
 end	 
	

//combinational always	
always @ (*)
 begin 
    Logic_OUT_comb =  'b0 ;
    Logic_Flag_comb = 1'b0 ;
	if(Logic_Enable)
      case (ALU_FUNC)
      2'b00 : begin
              Logic_OUT_comb = A & B ;
              Logic_Flag_comb = 1'b1 ;              
		      end
      2'b01 : begin
              Logic_OUT_comb = A | B ;
              Logic_Flag_comb = 1'b1 ;           
		      end
      2'b10 : begin
              Logic_OUT_comb = ~(A & B) ;
              Logic_Flag_comb = 1'b1 ;           
		      end
      2'b11 : begin
              Logic_OUT_comb = ~(A | B) ;
              Logic_Flag_comb = 1'b1 ;           
		      end
      endcase
	else
	 begin
      Logic_OUT_comb = 1'b0 ;
      Logic_Flag_comb = 1'b0 ;
     end
 end
 
 endmodule