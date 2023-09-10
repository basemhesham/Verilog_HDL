`timescale 1ns / 1ps

module mult_control(
input clk,reset_a,start,
input [1:0] count,
output reg [1:0] input_sel,shift_sel,
output  [2:0] state_out,
output reg done,clk_ena,sclr_n
);
// signal decleration
reg [2:0] state_reg,state_next;

//symbolic state decleration
localparam IDLE=3'b000;
localparam LSB=3'b001; 
localparam MID=3'b010; 
localparam MSB=3'b011; 
localparam CALC_DONE=3'b100; 
localparam ERR=3'b101; 
 
//state register
always@(posedge clk,negedge reset_a)
begin
if(~ reset_a)
	state_reg<=IDLE;
else
	state_reg<=state_next;
end

//next_state logic and output logic
always@(*)
begin
//default values
done = 1'b0 ;
clk_ena = 1'b0 ;
sclr_n = 1'b1 ;
input_sel = 2'bxx ;
shift_sel =2'bxx ;

	case(state_reg)
		IDLE: begin
		if(start) begin
			state_next=LSB;
			clk_ena = 1'b1 ;
            sclr_n = 1'b0 ;
			end
			
		  else
	         state_next=IDLE;
	      end
	      
  		LSB: begin
  		if(start==0 && count==2'b00) begin
			state_next=MID;
			input_sel = 2'b00 ;
            shift_sel =2'b00 ;
			clk_ena = 1'b1 ;
            sclr_n = 1'b1 ;
			end
		else
	       state_next=ERR;
	    end
	     
		MID : begin
		if(start==0 && count==2'b01) begin
			state_next=MID;
			input_sel = 2'b01 ;
            shift_sel =2'b01 ;
            clk_ena = 1'b1 ;
            sclr_n = 1'b1 ;
			end
			
		     else if(start==0 && count==2'b10) begin
			state_next=MSB;
			input_sel = 2'b10 ;
            shift_sel =2'b01 ;
            clk_ena = 1'b1 ;
            sclr_n = 1'b1 ;
			end
			
		     else
			state_next=ERR;
	      end
	             
		MSB:
		if(start==0 && count==2'b11) begin
			state_next=CALC_DONE;
			input_sel = 2'b11 ;
            shift_sel =2'b10 ;
            clk_ena = 1'b1 ;
             sclr_n = 1'b1 ;
			end
			
		   else
	        state_next=ERR;
	        	
 		CALC_DONE:
 		 if(start==0) begin
			state_next=IDLE;
			done = 1'b1 ;
			clk_ena = 1'b0 ;
            sclr_n = 1'b1 ;
	      end
	      
		  else
	        state_next=ERR;
	             
		ERR:
		if(start) begin
			state_next=LSB;
			clk_ena = 1'b1 ;
            sclr_n = 1'b0 ;
			end
			
		   else
	        state_next=ERR;
	        
		default:state_next=state_reg;
	endcase

end

assign state_out = state_reg ;

endmodule
