package fibonacci_pkg;
typedef enum logic [1:0] {
        idle = 2'b00,
        op  = 2'b01,
        done = 2'b10
} state_t;
endpackage