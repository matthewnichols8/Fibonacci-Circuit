/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_seq_lib.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Write more sequences extended from the provided base sequence (gcd_sequence.svh)
*      to create different test cases (ex. edge cases, randomized tests, etc) with the goal
*      to reach at least 96% coverage.
*
* A simple sequence that runs one randomized transaction is provided
-------------------------------------------------------------------------------------------------*/

// Example sequence extending the base sequence
class simple_fibonacci_seq extends base_fibonacci_seq;

    //gcd_seq_item seq1;

    // UVM Component Macro
    `uvm_object_utils(simple_fibonacci_seq)

    // UVM Constructor
    function new(string name = "simple_fibonacci_seq");
        super.new(name);
    endfunction : new

    // Sequence body definition
    virtual task body();
        // Example transaction generation logic
        // This is where you would define the specific sequence behavior
        `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
        repeat(50)
            `uvm_do(req)
        //'uvm_do_with(req, {req.data_a == 9'd300; req.data_b == 9'd300;})
        //`uvm_do(seq)
    endtask : body

endclass : simple_fibonacci_seq
