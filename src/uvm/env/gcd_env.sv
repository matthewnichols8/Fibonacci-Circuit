/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_env.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate the agent and scoreboard
*   4. Connect your monitor analysis port to the scoreboard analysis import
-------------------------------------------------------------------------------------------------*/

class gcd_env extends uvm_env;

    gcd_agent agent;
    gcd_sb scoreboard;

    `uvm_component_utils(gcd_env)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scoreboard = gcd_sb::type_id::create("scoreboard", this);
        agent = gcd_agent::type_id::create("agent", this);
        //scoreboard = gcd_sb::type_id::create("scoreboard", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        agent.monitor.item_collected_port.connect(scoreboard.sb_component_a);
    endfunction : connect_phase

endclass : gcd_env