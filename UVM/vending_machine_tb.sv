//inclue các class uvm được gom trong my_pkg
`include "../my_pkg/my_pkg.sv"
//import các class, macro của UVM và các thành phần định nghĩa trong my_pkg.
import uvm_pkg::*; 
import my_pkg::*;
module vending_machine_tb;
//khởi tạo interface ảo kết nối giữa DUT và testbench
vending_machine_if vm_if();
//kết nối DUT với các tín hiệu trong interface 
vending_machine dut(
.clk(vm_if.clk),
.rst(vm_if.rst),
.next_state_o(vm_if.next_state_o),
.current_state_o(vm_if.current_state_o),
.id_item(vm_if.id_item),
.coin(vm_if.coin),
.value_coin(vm_if.value_coin),
.product(vm_if.product),
.slot(vm_if.slot),
.coin_change(vm_if.coin_change),
.error_o(vm_if.error_o),
.done(vm_if.done)

);
//tạo chu kỳ xung clock
always #5 vm_if.clk=~vm_if.clk;

//khởi tạo các tín hiệu
initial begin
vm_if.clk = 0;
uvm_config_db #(virtual vending_machine_if)::set(null, "*", "vif", vm_if);
run_test("vending_machine_test"); //gọi tại time 0
end
initial begin
vm_if.rst = 1;
#4
vm_if.rst = 0;
@(posedge vm_if.clk); // này là tới 5/15 cập nhật giá trị
end
endmodule
