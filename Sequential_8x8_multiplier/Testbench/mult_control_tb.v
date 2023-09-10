`timescale 1ns / 1ps

module mult_control_tb( );
 // declare internal testbench signals
   reg clk, reset_a, start;
   reg [1:0] count;        
   wire done,clk_ena,sclr_n;
   wire [2:0] state_out;
   wire [1:0] input_sel,shift_sel;    

   // Instantiate the binary counter module with 4 bits
   mult_control dut (
   .clk(clk),
   .reset_a(reset_a),
   .start(start),
   .count(count),
   .done(done),
   .clk_ena(clk_ena),
   .sclr_n(sclr_n),
   .state_out(state_out),
   .input_sel(input_sel),
   .shift_sel(shift_sel)  
);

    // Generate clock signal
   localparam T = 50; // clk period
    always begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end

    // rst
    initial begin
        reset_a = 1'b0;
        #(3*T/2);
        reset_a = 1'b1;
    end
   // Stimulus generation
   initial begin
       // initial values
       start = 0;
       # T;
       @(negedge clk);
       start = 1'b1;
       #T;
       @(negedge clk);
       start = 1'b0;
       count= 2'b00;
       #T;
       @(negedge clk);
       count= 2'b01;
       #T; 
      @(negedge clk);
       count= 2'b10;
       #T;
       @(negedge clk);
       count=2'b11;
       #T;
       start = 1'b1;
       #T
       $stop;
   end
endmodule

