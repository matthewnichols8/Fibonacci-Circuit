/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_seq_item.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
-------------------------------------------------------------------------------------------------*/

class fibonacci_seq_item extends uvm_sequence_item;

    localparam TB_WIDTH = 5;

    // Data fields for the transaction
    rand bit [TB_WIDTH-1:0] data_f;

    bit [19:0] result_f;

    // UVM Component Macro
    `uvm_object_utils_begin(gcd_seq_item)
        // Register data fields for randomization and recording
        `uvm_field_int(data_f, UVM_ALL_ON)
        //`uvm_field_int(data_b, UVM_ALL_ON)
        `uvm_field_int(result_f, UVM_ALL_ON)
    `uvm_object_utils_end

    // UVM Constructor
    function new(string name = "fibonacci_seq_item");
        super.new(name);
    endfunction : new

    // Define desired constraints for randomization
    constraint valid_inputs {data_f >= 0; data_f <= 31;}

endclass : fibonacci_seq_item