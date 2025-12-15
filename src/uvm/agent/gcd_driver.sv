/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_driver.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
*   3. Instantiate and connect the driver to the DUT virtual interface (connect_phase)
*   4. Define the logic to drive transaction signals onto the DUT (run_phase)
-------------------------------------------------------------------------------------------------*/

class gcd_driver extends uvm_driver #(gcd_seq_item);

    `uvm_component_utils(gcd_driver)

    virtual interface gcd_if vif;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! gcd_vif_config::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Didnt get handle to virtual interface vif")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        gcd_seq_item data;
        super.run_phase(phase);
       // Gets packets from the sequencer and passes them to the driver. 
        forever begin
            // Get new item from the sequencer
            seq_item_port.get_next_item(data);
            // Drive the item
            vif.valid_i <= 1'b1;
            vif.a_i     <= data.data_a;
            vif.b_i     <= data.data_b;
            @(posedge vif.clk_i);
            vif.valid_i <= 1'b0;
            do @(posedge vif.clk_i); while (vif.valid_o !== 1'b1);
            vif.gcd_o   <= data.result_gcd;
            // Communicate item done to the sequencer
            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : gcd_driver