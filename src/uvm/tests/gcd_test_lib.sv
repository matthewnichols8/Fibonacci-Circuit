/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_test_lib.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
* Tasks to complete here:
*   1. Write more tests extended from the provided base test (gcd_base_test.svh)
*      to create different tests that run your different sequences.
-------------------------------------------------------------------------------------------------*/

// Example test that runs the simple example sequence
class simple_gcd_test extends base_gcd_test;

    // UVM Component Macro
    `uvm_component_utils(simple_gcd_test)

    // UVM Constructor
    function new(string name = "simple_gcd_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction : new

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        // Set the default sequence for the agent's sequencer
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence",
                                simple_gcd_seq::get_type());
        // Call the base class build_phase to create the testbench
        super.build_phase(phase);
    endfunction : build_phase

endclass : simple_gcd_test

class equal_gcd_test extends base_gcd_test;
    `uvm_component_utils(equal_gcd_test)

    function new(string name = "equal_gcd_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence", 
                                equal_gcd_seq::get_type());
        super.build_phase(phase);
    endfunction : build_phase

endclass : zero_gcd_test

class one_gcd_test extends base_gcd_test;
    `uvm_component_utils(one_gcd_test)

    function new(string name = "one_gcd_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence", 
                                one_gcd_seq::get_type());
        super.build_phase(phase);
    endfunction : build_phase

endclass : one_hundred_gcd_test

class max_gcd_test extends base_gcd_test;
    `uvm_component_utils(max_gcd_test)

    function new(string name = "max_gcd_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence", max_gcd_seq::get_type());
        super.build_phase(phase);
    endfunction : build_phase
endclass : max_gcd_test

class odd_even_gcd_test extends base_gcd_test;
    `uvm_component_utils(odd_even_gcd_test)

    function new(string name = "odd_even_gcd_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence", odd_even_gcd_seq::get_type());
        super.build_phase(phase);
    endfunction : build_phase
    
endclass : odd_even_gcd_test

class all_gcd_test extends base_gcd_test;
    `uvm_component_utils(all_gcd_test)

    function new(string name = "all_gcd_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                "default_sequence", 
                                all_gcd_seq::get_type());
        super.build_phase(phase);
    endfunction : build_phase

endclass : all_gcd_test
