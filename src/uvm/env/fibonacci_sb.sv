/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_sb.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Create a UVM analysis import to receive transactions from the monitor
*   4. Define the logic to handle incoming transactions and update provided statistics (in write)
*
* We have provided a golden function to compute the gcd that you can use to 
* compare received with expected outputs
-------------------------------------------------------------------------------------------------*/

class fibonacci_sb extends uvm_scoreboard;

    //`uvm_analysis_imp_decl(_component_a)

    //uvm_analysis_imp_component_a #(gcd_seq_item, gcd_sb) sb_component_a;
    uvm_analysis_imp #(fibonacci_seq_item, fibonacci_sb) sb_component_a;

    `uvm_component_utils(fibonacci_sb)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        sb_component_a = new("sb_component_a", this);
    endfunction

    // Scoreboard statistics. You can optionally add more if you want
    int num_in, num_correct, num_incorrect;

    // Golden Fibonacci function
    function automatic bit [19:0] compute_fibonacci(bit [5:0] n);
        bit [19:0] a = 0;
        bit [19:0] b = 1;
        bit [19:0] next;

        if (n == 0) return 0;
        if (n == 1) return 1;

        for (int i = 2; i <= n; i++) begin
            next = a + b;
            a = b;
            b = next;
        end

        return b;
    endfunction

    virtual function void write (fibonacci_seq_item tr);
        `uvm_info(get_type_name(), "Recieved item in scoreboard", UVM_LOW)
        num_in++;
        if (compute_fibonacci(tr.data_i) != tr.result_f)
            num_incorrect++;
        else
            num_correct++;
    endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report:\n\n   Scoreboard: Simulation Statistics \n     Num In:   %0d     Num Correct: %0d\n     Num Incorrect: %0d\n", num_in, num_correct, num_incorrect), UVM_LOW)
        if (num_incorrect > 0)
            `uvm_error(get_type_name(), "Status:\n\nSimulation FAILED\n")
        else
            `uvm_info(get_type_name(), "Status:\n\nSimulation PASSED\n", UVM_NONE)
    endfunction : report_phase


endclass : fibonacci_sb
