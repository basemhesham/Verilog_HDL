
module Door_Controller (

input      wire        CLK,
input      wire        RST,
input      wire        Activate,
input      wire        Up_Max,
input      wire        Dn_Max,
output     reg         Up_M,
output     reg         Dn_M
);


//states
localparam          IDLE  = 2'b00 ,
                    Mv_Up = 2'b01 ,                    
                    Mv_Dn = 2'b10 ;

reg      [1:0]      current_state ,
                    next_state ;


//state transition
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    current_state <= IDLE ;
   end
  else
   begin
    current_state <= next_state ;
   end
 end


//next state logic
always @ (*)
 begin
   case (current_state)
   IDLE   :  begin
              if(Activate && Up_Max && !Dn_Max)
                begin
                 next_state = Mv_Dn  ;
                end
              else if(Activate && Dn_Max && !Up_Max)
                begin
                 next_state = Mv_Up  ;
                end
              else   // !Activate
                begin
                 next_state = IDLE  ;
                end  
             end
   Mv_Up  :  begin
              if(Up_Max)
                begin
                 next_state = IDLE  ;
                end
              else  
                begin
                 next_state = Mv_Up  ;
                end        
             end
   Mv_Dn  :  begin
              if(Dn_Max)
                begin
                 next_state = IDLE  ;
                end
              else  
                begin
                 next_state = Mv_Dn  ;
                end        
             end
   default : begin
                 next_state = IDLE  ;
             end  
   endcase   
 end


//output logic
always @ (*)
 begin
  Up_M  = 1'b0 ;
  Dn_M  = 1'b0 ;
   case (current_state)
   IDLE   :  begin
              Up_M  = 1'b0 ;
              Dn_M  = 1'b0 ;
             end
   Mv_Up  :  begin
              Up_M  = 1'b1 ;
             end
   Mv_Dn  :  begin
              Dn_M  = 1'b1 ;
             end
   default : begin
              Up_M  = 1'b0 ;
              Dn_M  = 1'b0 ;
             end  
   endcase   
 end


endmodule
