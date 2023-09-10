`timescale 1ns/1ns

module Counter_tb;
reg clk;
reg aclr_n;
wire [1:0] count_out;

Counter uut(
  .clk(clk),
  .aclr_n(aclr_n),
  .count_out(count_out)
);

localparam T = 50 ;
always
begin
clk = 1'b1 ;
#(T/2) ;
clk = 1'b0 ;
#(T/2) ;
end

initial begin
  clk = 0;
  aclr_n = 0;
  #100 aclr_n = 1;
  #100 aclr_n = 1;
  #100 aclr_n = 1;
  #100 aclr_n = 0;
  #100 $stop;
end

endmodule

