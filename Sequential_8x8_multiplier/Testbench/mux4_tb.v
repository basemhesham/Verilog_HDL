`timescale 1ns / 1ps

module mux4_tb;
  // Inputs
  reg [7:0] dataa;
  reg [7:0] datab;
  reg [1:0] sel;
  // Outputs
  wire [3:0] aout;
  wire [3:0] bout;

  // Instantiate the module
  mux4 uut (
    .dataa(dataa),
    .datab(datab),
    .sel(sel),
    .aout(aout),
    .bout(bout)
  );

// timer
  initial
  #200 $stop;
  
  // Initialize inputs
  initial begin
    dataa = 8'b11110000;
    datab = 8'b10100101;
    sel = 2'b00;
     #50 sel = 2'b01;
     #50 sel = 2'b10;
     #50 sel = 2'b11;
  end

endmodule