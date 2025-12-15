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

class fibonacci_driver extends uvm_driver #(fibonacci_seq_item);

    `uvm_component_utils(fibonacci_driver)

    virtual interface fibonacci_if vif;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! fibonacci_vif_config::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Didnt get handle to virtual interface vif")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        fibonacci_seq_item data;
        super.run_phase(phase);
       // Gets packets from the sequencer and passes them to the driver. 
        forever begin
            // Get new item from the sequencer
            seq_item_port.get_next_item(data);
            // Drive the item
            vif.start_i <= 1'b1;
            vif.i_i     <= data.i;
            @(posedge vif.clk_i);
            //vif.valid_i <= 1'b0;
            do @(posedge vif.clk_i); while (vif.done_tick_o !== 1'b1);
            vif.f_o   <= data.result_f;
            // Communicate item done to the sequencer
            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : fibonacci_driver