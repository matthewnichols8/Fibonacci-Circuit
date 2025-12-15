package fibonacci_env_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import fibonacci_seq_pkg::*;
  import fibonacci_agent_pkg::*;
  `include "fibonacci_sb.sv"
  `include "fibonacci_env.sv"

endpackage : fibonacci_env_pkg
