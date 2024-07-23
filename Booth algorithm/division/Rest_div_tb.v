module Rest_div_tb;

    reg clk, rst, start;
    reg [3:0] Q, M;
    wire [3:0] quot, rem;
    wire valid;

    always #5 clk = ~clk;

    Rest_div inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .Q(Q),
        .M(M),
        .valid(valid),
        .quot(quot),
        .rem(rem)
    );

    initial begin
        Q = 7;
        M = 3;
        clk = 1'b1;
        rst = 1'b0;
        start = 1'b0;
        
        #10 rst   = 1'b1;
        #10 start = 1'b1;
        #10 start = 1'b0;
        
        @valid;
        #10 
        Q = -7;
        M = 3;
        start = 1'b1;
        #10 start = 1'b0;
    end

endmodule
