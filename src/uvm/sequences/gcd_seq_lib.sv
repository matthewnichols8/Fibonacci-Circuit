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
class simple_gcd_seq extends base_gcd_seq;

    //gcd_seq_item seq1;

    // UVM Component Macro
    `uvm_object_utils(simple_gcd_seq)

    // UVM Constructor
    function new(string name = "simple_gcd_seq");
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

endclass : simple_gcd_seq

class equal_gcd_seq extends base_gcd_seq;
    `uvm_object_utils(equal_gcd_seq)

    function new(string name = "equal_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(),"Executing equal sequence", UVM_LOW)
        repeat(5)
            `uvm_do_with(req, {req.data_a == req.data_b;})
    endtask
endclass : equal_gcd_seq

class one_gcd_seq extends base_gcd_seq;
    `uvm_object_utils(one_gcd_seq)

    function new(string name = "one_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing ONE sequence", UVM_LOW)
        `uvm_do_with(req, {req.data_a == 1; req.data_b == 1;})
    endtask
endclass : one_gcd_seq

class max_gcd_seq extends base_gcd_seq;
    `uvm_object_utils(max_gcd_seq)

    function new(string name = "max_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing max sequence", UVM_LOW)
        `uvm_do_with(req, {req.data_a == 255; req.data_b == 255;})
    endtask : body

endclass : max_gcd_seq

class odd_even_gcd_seq extends base_gcd_seq;
    `uvm_object_utils(odd_even_gcd_seq)

    function new(string name = "odd_even_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing odd_even sequence", UVM_LOW)
        repeat(5)
            `uvm_do_with(req, {req.data_a % 2 == 0; req.data_b % 2 == 1;})
            //`uvm_do_with(req, {req.data_a % 2 == 1; req.data_b % 2 == 0;})
    endtask : body

endclass : odd_even_gcd_seq

class all_gcd_seq extends base_gcd_seq;
    `uvm_object_utils(all_gcd_seq)

    simple_gcd_seq    simpleSeq;
    equal_gcd_seq      equalSeq;
    one_gcd_seq          oneSeq;
    max_gcd_seq          maxSeq;
    odd_even_gcd_seq oddEvenSeq;

    function new(string name = "all_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(),"Executing all sequence", UVM_LOW)
        `uvm_do(simpleSeq)
        `uvm_do(equalSeq)
        `uvm_do(oneSeq)
        `uvm_do(maxSeq)
        `uvm_do(oddEvenSeq)
    endtask
endclass : all_gcd_seq



