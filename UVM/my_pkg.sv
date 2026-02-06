//my_pkg.sv
//tránh inclue trùng file 
`ifndef MY_PKG_SV
`define MY_PKG_SV
//nạp gói thư viện macro cho phép sử dụng uvm_component_utils, uvm_object_utils tạo macro
`include "uvm_macros.svh"
package my_pkg; 
import uvm_pkg::*; //import uvm_pkg để sử dụng uvm_env, uvm_driver
// Include tất cả các file class liên quan đến UVM
 `include "../vending_machine_transaction/vending_machine_transaction.sv"
 `include "../vending_machine_sequence/vending_machine_sequence.sv"
 `include "../vending_machine_sequencer/vending_machine_sequencer.sv"
 `include "../vending_machine_driver/vending_machine_driver.sv"
 `include "../vending_machine_monitor/vending_machine_monitor.sv"
 `include "../vending_machine_agent/vending_machine_agent.sv"
 `include "../vending_machine_scoreboard/vending_machine_scoreboard.sv"
 `include "../vending_machine_subscriber/vending_machine_subscriber.sv"
 `include "../vending_machine_environment/vending_machine_environment.sv"
 `include "../vending_machine_test/vending_machine_test.sv"
endpackage
`endif
