module uart_rx_fsm(
  input          RX_IN, PAR_EN,
  input [4:0]    edge_cnt,
  input [3:0]    bit_cnt,
  input          strt_glitch, stp_err, par_err,
  input          CLK, RST,
  output reg     dat_samp_en, enable,
  output reg     deser_en, stp_chk_en,
  output reg     strt_chk_en, par_chk_en,
  output reg     data_valid
);
  
  //Registers to store present state and next state
  reg [2:0] present_state, next_state;  
  
  //FSM states
  parameter [2:0] IDLE = 3'b000;
  parameter [2:0] STR = 3'b001;
  parameter [2:0] DATA = 3'b010;
  parameter [2:0] PARITY = 3'b011;
  parameter [2:0] STP = 3'b100;
  parameter [2:0] VALID = 3'b101;
  

  always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        present_state <= IDLE;
      end
    else present_state <= next_state;
  end
  
  
  //Next state logic
  always@(*)
  begin
    next_state = IDLE;
    case(present_state)
        IDLE:
          begin
            if(RX_IN == 1'b0) 
               next_state = STR;
            else next_state = IDLE;
          end
        
        STR: begin
              if(strt_glitch ==1'b0 && bit_cnt == 1)
                next_state = DATA;
              
              else
                next_state = IDLE;
             end 
        
        DATA:
          begin
            if(PAR_EN == 1'b1 && bit_cnt == 8) 
               next_state = PARITY;
            else if (PAR_EN == 1'b0 && bit_cnt == 8)
               next_state = STP;
            else next_state = DATA;
          end
          
        PARITY: begin
                 if(par_err == 1'b0 && bit_cnt == 9)
                    next_state = STP;
              
                 else
                    next_state = IDLE;
                end 
        
        STP:
          begin
            if(stp_err == 1'b0) 
               next_state = VALID;
            else next_state = IDLE;
          end
          
        VALID:
          begin
            if(RX_IN == 1'b0) 
               next_state = STR;
            else next_state = IDLE;
          end
        
        default: next_state = IDLE;
          
      endcase
  end  
    
  
  //Output Logic
  always@(*)
  begin
    dat_samp_en = 1'b0;
    enable = 1'b0;
    deser_en = 1'b0;
    stp_chk_en = 1'b0;
    strt_chk_en = 1'b0;
    par_chk_en = 1'b0;
    data_valid = 1'b0;
    
    case(present_state)      
        IDLE:
          begin
             dat_samp_en = 1'b0;
             enable = 1'b0;
             deser_en = 1'b0;
             stp_chk_en = 1'b0;
             strt_chk_en = 1'b0;
             par_chk_en = 1'b0;
             data_valid = 1'b0;
          end
        
        STR:
          begin
             dat_samp_en = 1'b1;
             enable = 1'b1;
             if (bit_cnt == 0)
               strt_chk_en = 1'b1;
             
             else strt_chk_en = 1'b0;
             deser_en = 1'b0;
             stp_chk_en = 1'b0;
             par_chk_en = 1'b0;
             data_valid = 1'b0;
          end 
        
        DATA:
          begin
             dat_samp_en = 1'b1;
             enable = 1'b1;
             deser_en = 1'b1;
             stp_chk_en = 1'b0;
             par_chk_en = 1'b0;
             data_valid = 1'b0;
          end
          
        PARITY:
          begin
             deser_en = 1'b0;
             stp_chk_en = 1'b0;
             par_chk_en = 1'b1;
             data_valid = 1'b0;
          end
        
        STP:
          begin
             stp_chk_en = 1'b1;
             data_valid = 1'b0;
          end
        
        VALID: data_valid = 1'b1;
          
        default:
          begin
             dat_samp_en = 1'b0;
             enable = 1'b0;
             deser_en = 1'b0;
             stp_chk_en = 1'b0;
             strt_chk_en = 1'b0;
             par_chk_en = 1'b0;
             data_valid = 1'b0;
          end
      endcase
  end  
  
  
endmodule