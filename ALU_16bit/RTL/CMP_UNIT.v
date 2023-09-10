module CMP_UNIT 

#( parameter IN_DATA_WIDTH  = 16,
             OUT_DATA_WIDTH = 2
)

(
input  wire [IN_DATA_WIDTH-1:0]   A   ,
input  wire [IN_DATA_WIDTH-1:0]   B   ,
input  wire [1:0]                 ALU_FUNC ,
input  wire                       CLK ,
input  wire                       RST ,
input  wire                       CMP_Enable ,
output reg  [OUT_DATA_WIDTH-1:0]  CMP_OUT ,
output reg                        CMP_Flag
);

//internal signals
reg [OUT_DATA_WIDTH-1:0]  CMP_OUT_comb  ;
reg                       CMP_Flag_comb ;

//sequential always
always @ (posedge CLK or negedge RST)
 begin 
   if (~RST)
     begin
      CMP_OUT  <= 'b0 ;
      CMP_Flag <= 1'b0 ;	
	 end
   else
     begin   
      CMP_OUT  <= CMP_OUT_comb ;
      CMP_Flag <= CMP_Flag_comb ;
	 end
 end	
 
 
//combinational always	
always @ (*)
 begin 
    CMP_OUT_comb = 'b0 ;
    CMP_Flag_comb = 1'b0 ;
	if(CMP_Enable)
      case (ALU_FUNC)
      2'b00 : begin
              CMP_OUT_comb = 'b0  ;
              CMP_Flag_comb = 1'b1 ;              
		      end
      2'b01 : begin
              CMP_Flag_comb = 1'b1 ;  
              if (A==B)
                CMP_OUT_comb = 'b1;
              else
                CMP_OUT_comb = 'b0;			  
		      end
      2'b10 : begin
              CMP_Flag_comb = 1'b1 ;  
              if (A>B)
                CMP_OUT_comb = 'b10;
              else
                CMP_OUT_comb = 'b0;			  
		      end
      2'b11 : begin
              CMP_Flag_comb = 1'b1 ; 
              if (A<B)
                CMP_OUT_comb = 'b11;
              else
                CMP_OUT_comb = 'b0;			  
		      end
      endcase
	else
	 begin
      CMP_OUT_comb = 'b0 ;
      CMP_Flag_comb = 1'b0 ;
     end
 end
 
 endmodule