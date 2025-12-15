/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_monitor.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate and connect the monitor to the DUT virtual interface (connect_phase)
*   4. Define the logic to monitor transaction signals from the DUT (run_phase)
*   5. Create a UVM analysis port that writes monitored transactions to the scoreboard
-------------------------------------------------------------------------------------------------*/

class gcd_monitor extends uvm_monitor;

    `uvm_component_utils(gcd_monitor)

    virtual interface gcd_if vif;
    gcd_seq_item collected_data;
    uvm_analysis_port #(gcd_seq_item) item_collected_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (! gcd_vif_config::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        @(negedge vif.rst_i);
        forever begin
            wait(! vif.rst_i);
            @(posedge vif.valid_o);
            collected_data = gcd_seq_item::type_id::create("collected_data", this);
            void'(begin_tr(collected_data, "Monitor_Data"));
            collected_data.data_a = vif.a_i;
            collected_data.data_b = vif.b_i;
            collected_data.result_gcd = vif.gcd_o;
            end_tr(collected_data);
            item_collected_port.write(collected_data);
            `uvm_info(get_type_name(), $sformatf("Collected: a=%0d b=%0d gcd=%0d", 
                                                collected_data.data_a, 
                                                collected_data.data_b, 
                                                collected_data.result_gcd),
                                                UVM_LOW)
        @(negedge vif.valid_o);
        end
    endtask : run_phase

endclass : gcd_monitor