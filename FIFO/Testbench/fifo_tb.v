`timescale 1ns / 1ps

module fifo_tb;
  // Parameters
  parameter DSIZE = 8;
  parameter ASIZE = 4;
  
  // Signals
  reg [DSIZE-1:0] wdata;
  reg winc, wclk, wrst_n;
  reg rinc, rclk, rrst_n;
  wire [DSIZE-1:0] rdata;
  wire wfull, rempty;
  
  // Instantiate the FIFO module
  fifo #(DSIZE, ASIZE) dut (
    .rdata(rdata),
    .wfull(wfull),
    .rempty(rempty),
    .wdata(wdata),
    .winc(winc),
    .wclk(wclk),
    .wrst_n(wrst_n),
    .rinc(rinc),
    .rclk(rclk),
    .rrst_n(rrst_n)
  );
  
  // Clock generation
  always begin
    wclk = 0;
    #3;
    wclk = 1;
    #3;
  end
  
  always begin
    rclk = 0;
    #8;
    rclk = 1;
    #8;
  end
  
  
  // Reset generation
  initial begin
   wdata = 8'b00000000;
    rinc = 1;
    winc = 1;
    wrst_n = 0;
    rrst_n = 0;
    #7;
   wdata = 8'b00000001;
   wrst_n = 1;
    #7;
   wdata = 8'b00000010;
    #7
   wdata = 8'b00000011;
      rrst_n = 1;
    #7
    wdata = 8'b00000100;
    #7
    wdata = 8'b00000101;
    #7
   wdata = 8'b00000110;
    #7
    wdata = 8'b00000111;
    #7
   wdata = 8'b00001000;
   #7
   wdata = 8'b00001001;
   #7
    wdata = 8'b00001010;
    #7
    wdata = 8'b00001011;
    #7
    wdata = 8'b00001100;
    #7
    wdata = 8'b00001101;
    #7
   wdata = 8'b00001110;
   #7
  wdata = 8'b00001111;
     #20
    $stop;
  end

endmodule