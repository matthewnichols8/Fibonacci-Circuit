/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_tb_top.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
-------------------------------------------------------------------------------------------------*/

module fibonacci_tb_top;

    timeunit 1ns;
    timeprecision 100ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import fibonacci_test_pkg::*;
    import fibonacci_seq_pkg::*;
    import fibonacci_agent_pkg::*;
    import fibonacci_env_pkg::*;

    logic clk = 0;
    logic rst = 0;

    always #10ns clk = ~clk;

    initial begin
        rst = 1'b1;
        #10ns rst = 1'b0;
    end

    // Interface instantiation
    fibonacci_if if0(clk, rst);

    // DUT instantiation
    fibonacci dut(
        .clk_i(clk),
        .rst_i(rst),
        .start(if0.start_i),
        .i(if0.i_i),
        .ready(if0.ready_o),
        .done_tick(if0.done_tick_o),
        .f(if0.f_o));

    initial begin
        // Initialize waveform dumping
        $shm_open("waves.shm");
        $shm_probe("AS");
        // Store the virtual interface handle 'if0' in the UVM configuration database
        // under the field name "vif" so all components under uvm_root can access it.
        uvm_config_db #(virtual fibonacci_if)::set(uvm_root::get(), "*", "vif", if0);
        run_test();
    end

endmodule : fibonacci_tb_top
