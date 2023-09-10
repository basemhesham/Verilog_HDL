`timescale 1ns / 1ps

module Top_module_tb;

reg [7:0] dataa, datab;
reg clk, reset_a, start;
wire done;
wire [15:0] product8x8_out;
wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;

Top_module uut(
    .dataa(dataa),
    .datab(datab),
    .clk(clk),
    .reset_a(reset_a),
    .start(start),
    .done(done),
    .product8x8_out(product8x8_out),
    .seg_a(seg_a),
    .seg_b(seg_b),
    .seg_c(seg_c),
    .seg_d(seg_d),
    .seg_e(seg_e),
    .seg_f(seg_f),
    .seg_g(seg_g)
);

//clock
localparam T = 50 ;
 always
 begin
  clk = 1'b1 ;
  #(T/2) ;
  clk = 1'b0 ;
  #(T/2) ;
 end
    
   // rst
    initial begin
        reset_a = 1'b0;
        #(3*T/2);
        reset_a = 1'b1;
    end
    
  initial 
  begin
  dataa = 8'b00100111;
  datab = 8'b11001001;
  start = 1'b0;
   #(2*T);
   @(negedge clk);
   start = 1'b1;
   #T;
   @(negedge clk);
    start = 1'b0;
    #(5*T);
    @(negedge clk);
     start = 1'b0;
     #T;
     start = 1'b1;
     #(2*T);
     $stop;
end

endmodule

