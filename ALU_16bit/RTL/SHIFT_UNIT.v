module SHIFT_UNIT 

#( parameter IN_DATA_WIDTH = 16 ,
             OUT_DATA_WIDTH = 16
)

(
input  wire [IN_DATA_WIDTH-1:0]  A   ,
input  wire [IN_DATA_WIDTH-1:0]  B   ,
input  wire [1:0]                ALU_FUNC ,
input  wire                      CLK ,
input  wire                      RST ,
input  wire                      Shift_Enable ,
output reg  [OUT_DATA_WIDTH-1:0] Shift_OUT,
output reg                       Shift_Flag
);

//internal signals
reg [OUT_DATA_WIDTH-1:0]  Shift_OUT_comb  ;
reg                       Shift_Flag_comb ;

//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (!RST)
     begin
      Shift_OUT  <= 'b0 ;
      Shift_Flag <= 'b0 ;	
	 end
   else
     begin   
      Shift_OUT  <= Shift_OUT_comb ;
      Shift_Flag <= Shift_Flag_comb ;
	 end
 end	

//combinational always	
always @ (*)
 begin 
    Shift_OUT_comb = 1'b0 ;
    Shift_Flag_comb = 1'b0 ;
	if(Shift_Enable)
      case (ALU_FUNC)
      2'b00 : begin
              Shift_OUT_comb = A >> 1  ;
              Shift_Flag_comb = 1'b1 ;              
		      end
      2'b01 : begin
              Shift_OUT_comb = A << 1 ;
              Shift_Flag_comb = 1'b1 ;           
		      end
      2'b10 : begin
              Shift_OUT_comb = B >> 1 ;
              Shift_Flag_comb = 1'b1 ;           
		      end
      2'b11 : begin
              Shift_OUT_comb = B << 1 ;
              Shift_Flag_comb = 1'b1 ;           
		      end
      endcase
	else
	 begin
      Shift_OUT_comb = 'b0 ;
      Shift_Flag_comb = 1'b0 ;
     end
 end
 
 endmodule