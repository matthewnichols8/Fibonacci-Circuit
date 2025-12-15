module fibonacci(
    input logic clk, rst,
    input logic start,
    input logic [4:0] i,
    output logic ready, done_tick,
    output logic [19:0] f
);

    typedef enum {idle, op, done} state_t;
    state_t state_reg, state_next;

    logic [19:0] t0_reg, t0_next, t1_reg, t1_next;
    logic [4:0] n_reg, n_next;

    // Register Logic
    always_ff(@posedge clk) begin
        if (rst) begin
            t0_reg <= '0;
            t1_reg <= '0;
            n_reg <= '0;
            state_reg <= idle;
        end else begin
            t0_reg <= t0_next;
            t1_reg <= t1_next;
            n_reg <= n_next;
            state_reg <= state_next;
        end
    end

    //Next State Logic
    always_comb() begin
        state_next = state_reg;
        t0_next = t0_reg;
        t1_next = t1_reg;
        n_next = n_reg;
        done_tick = 1'b0;
        case (state_reg) begin
            idle: begin
                ready = 1'b1;
                if (start) begin
                    t0_next = '0;
                    t1_next = 20'd1;
                    n_next = i;
                    state_next = op;
                end
            end
            op: begin
                if (n_reg == 5'd0) begin
                    t1_next = 20'd0;
                    state_next = done;
                end else if (n_reg == 5'd1) state_next = done;
                else begin
                    t1_next = t1_reg + t0_reg;
                    t0_next = t1_reg;
                    n_next = n_reg - 1;
                end
            end
            done: begin
                done_tick = 1'b1;
                state_next = idle;
            end
            default: state_next = idle;
        end
        endcase
    end

    assign f = t1_reg;

endmodule 