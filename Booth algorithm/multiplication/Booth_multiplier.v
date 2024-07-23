module Booth_multiplier(
    input                    clk,
    input                    rst,
    input                    start,
    input      signed [3:0]  M,     // Multiplicand
    input      signed [3:0]  Q,     // Multiplier
    output reg signed [7:0]  acc,   // Accumulator (Product)
    output reg               valid
);

reg signed [7:0]  next_acc, acc_temp;
reg               next_state, pres_state;
reg        [1:0]  temp, next_temp;
reg        [1:0]  count, next_count;
reg               next_valid;

parameter IDLE = 1'b0;
parameter START = 1'b1;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        acc        <= 8'd0;
        valid      <= 1'b0;
        pres_state <= 1'b0;
        temp       <= 2'd0;
        count      <= 2'd0;
    end else begin
        acc        <= next_acc;
        valid      <= next_valid;
        pres_state <= next_state;
        temp       <= next_temp;
        count      <= next_count;
    end
end

always @(*) begin
    case (pres_state)
        IDLE: begin
            next_count = 2'b0;
            next_valid = 1'b0;
            if (start) begin
                next_state = START;
                next_temp  = {Q[0], 1'b0};
                next_acc   = {4'd0, Q};
            end else begin
                next_state = pres_state;
                next_temp  = 2'd0;
                next_acc   = 8'd0;
            end
        end

        START: begin
            case (temp)
                2'b10:   acc_temp = {acc[7:4] - M, acc[3:0]};
                2'b01:   acc_temp = {acc[7:4] + M, acc[3:0]};
                default: acc_temp = {acc[7:4], acc[3:0]};
            endcase
            next_temp  = {Q[count + 1], Q[count]};
            next_count = count + 1'b1;
            next_acc   = acc_temp >>> 1;
            next_valid = (&count) ? 1'b1 : 1'b0;
            next_state = (&count) ? IDLE : pres_state;
        end
    endcase
end

endmodule
