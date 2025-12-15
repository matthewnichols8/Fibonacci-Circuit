package fibonacci_agent_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    typedef uvm_config_db#(virtual fibonacci_if) fibonacci_vif_config;
    import fibonacci_seq_pkg::*;
    `include "fibonacci_driver.sv"
    `include "fibonacci_monitor.sv"
    `include "fibonacci_sequencer.sv"
    `include "fibonacci_agent.sv"
endpackage : fibonacci_agent_pkg