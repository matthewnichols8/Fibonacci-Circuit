/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_sequencer.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor
-------------------------------------------------------------------------------------------------*/

class fibonacci_sequencer extends uvm_sequencer #(fibonacci_seq_item);
    `uvm_component_utils(fibonacci_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass : fibonacci_sequencer