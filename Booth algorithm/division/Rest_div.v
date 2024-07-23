module Rest_div (
    input               clk,
    input               rst,
    input               start,
    input      [3:0]    Q,     // Dividend
    input      [3:0]    M,     // Divisor
    output     [3:0]    quot,  // Quotient
    output     [3:0]    rem,   // Remainder
    output reg          valid
);

    reg [7:0] Z, next_Z, Z_temp, Z_temp1 ;
    reg [3:0] rem_reg , quot_reg , Q_reg;
    reg next_state, pres_state;
    reg [1:0] count, next_count;
    reg  next_valid;

    parameter IDLE = 1'b0;
    parameter START = 1'b1;

    assign rem  = rem_reg;
    assign quot = quot_reg;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            Z <= 8'd0;
            valid <= 1'b0;
            pres_state <= IDLE;
            count <= 2'd0;
        end else begin
            Z <= next_Z;
            valid <= next_valid;
            pres_state <= next_state;
            count <= next_count;
        end
    end

    always @(*) begin
        next_state = pres_state;
        next_Z = Z;
        next_valid = 1'b0;
        next_count = count;

        case (pres_state)
            IDLE: begin
                next_count = 2'b0;
                if (start) begin
                    next_state = START;
                    next_Z = {4'd0, Q_reg};
                end else begin
                    next_Z = 8'd0;
                end
            end

            START: begin
                next_count = count + 1'b1;
                Z_temp = Z << 1;
                Z_temp1 = {Z_temp[7:4] - M, Z_temp[3:0]};
                next_Z = Z_temp1[7] ? {Z_temp[7:4], Z_temp[3:1], 1'b0} :
                                      {Z_temp1[7:4], Z_temp[3:1], 1'b1};
                next_valid = (&count) ? 1'b1 : 1'b0;
                next_state = (&count) ? IDLE : START;
            end
        endcase
    end
    
    always @(*) begin
        rem_reg  =  Q[3] ? (~Z[7:4] + 1) : Z[7:4];
        quot_reg = (Q[3] || M[3]) ? (~ Z[3:0] + 1) : Z[3:0];
        Q_reg    =  Q[3] ? (~Q+1) : Q ;
    end
    
endmodule
