/*-----------------------------------------------------------------------------------------------
* File Name     :   interface_template.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
* 
* This file defines an interface template that is connected to the DUT and provides 
* methods for the driver and monitor to interact with the DUT signals.
-------------------------------------------------------------------------------------------------*/

interface fibonacci_if(input logic clk_i, input logic rst_i);
timeunit 1ns;
timeprecision 100ps;

    localparam TB_WIDTH = 5;

    // Define actual DUT signals here
    logic start_i;
    logic [TB_WIDTH-1:0] i_i;
    logic ready_o;
    logic done_tick_o;
    logic [19:0] f_o;

endinterface : fibonacci_if