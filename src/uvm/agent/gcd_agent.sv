/*-----------------------------------------------------------------------------------------------
* File Name     :   agent_template.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate your driver, monitor, and sequencer based on is_active
*   4. Connect your sequencer to your driver based on is_active
-------------------------------------------------------------------------------------------------*/

class gcd_agent extends uvm_agent;

    gcd_monitor monitor;
    gcd_driver driver;
    gcd_sequencer sequencer;

    `uvm_component_utils_begin(gcd_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = gcd_monitor::type_id::create("monitor", this);
        //agent.is_active = UVM_ACTIVE; 
        if (get_is_active()) begin
            driver = gcd_driver::type_id::create("driver", this);
            sequencer = gcd_sequencer::type_id::create("sequencer", this);
        end
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if(get_is_active())  
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

endclass : gcd_agent