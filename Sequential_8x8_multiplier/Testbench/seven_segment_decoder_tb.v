`timescale 1ns / 1ps

module seven_segment_decoder_tb;
reg [2:0] inp;
wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;

seven_segment_decoder decoder(
    .inp(inp),
    .seg_a(seg_a),
    .seg_b(seg_b),
    .seg_c(seg_c),
    .seg_d(seg_d),
    .seg_e(seg_e),
    .seg_f(seg_f),
    .seg_g(seg_g)
);
initial begin
    inp = 3'b000; // Test input 0
    #10;
    inp = 3'b001; // Test input 1
    #10;
    inp = 3'b010; // Test input 2
    #10;
    inp = 3'b011; // Test input 3
    #10;
    inp = 3'b100; // Test input 4 (invalid input)
    #10;
    inp = 3'b101; // Test input 5 (invalid input)
    #10;
    inp = 3'b110; // Test input 6 (invalid input)
    #10;
    inp = 3'b111; // Test input 7 (invalid input)
    #10  $stop;
end
endmodule

