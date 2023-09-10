module data_sampling
(
   input             CLK ,
   input             RST ,
   input   [4:0]     edge_cnt ,
   input             data_samp_en ,
   input             RX_IN ,
   input   [4:0]     prescale ,
   output            sampled_bit
    );

   reg [2:0] samples; // Register to store sampled values

   always @(posedge CLK or negedge RST) begin
      if (~RST) 
         samples <= 3'b000; // Reset the samples register on negative edge of RST
      else if (data_samp_en) begin
         case (prescale)
            5'd8: begin
               if (edge_cnt == 5'd3)
                  samples[0] <= RX_IN; 
               else if (edge_cnt == 5'd4)
                  samples[1] <= RX_IN; 
               else if (edge_cnt == 5'd5)
                  samples[2] <= RX_IN; 
            end
            5'd16: begin
               if (edge_cnt == 5'd7)
                  samples[0] <= RX_IN; 
               else if (edge_cnt == 5'd8)
                  samples[1] <= RX_IN; 
               else if (edge_cnt == 5'd9)
                  samples[2] <= RX_IN;
            end
            default : samples <= 3'b000;
         endcase
      end
   end

   assign sampled_bit = ((samples[0] && samples[1]) || (samples[0] && samples[2]) || (samples[1] && samples[2]));
   // Compute sampled_bit based on the sampled values in the samples register

endmodule