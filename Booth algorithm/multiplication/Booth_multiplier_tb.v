module Booth_multiplier_tb;

  reg                  clk;
  reg                  rst;
  reg                  start;
  reg  signed [3:0]    Q, M;
  wire signed [7:0]    acc;
  wire                 valid;
 
  always #5 clk <= ~clk;

  Booth_multiplier mult (
    .clk(clk),
    .rst(rst),
    .start(start),
    .Q(Q),
    .M(M),
    .valid(valid),
    .acc(acc)
  );

  initial begin
    Q     = -6;
    M     = 5;
    clk   = 1'b1;
    rst   = 1'b0;
    start = 1'b0;

    #10 rst = 1'b1;
    #10 start = 1'b1;
    #10 start = 1'b0;

    @(posedge valid);
    #10;

    Q <= 3;
    M <= 7;
    start <= 1'b1;
    #10 start <= 1'b0;
  end

endmodule
