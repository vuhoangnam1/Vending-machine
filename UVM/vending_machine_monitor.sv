//kế thừa từ uvm_monitor, dùng để quan sát output từ DUT và gửi sang scoreboard
class vending_machine_monitor extends uvm_monitor;
int count=0; 
`uvm_component_utils(vending_machine_monitor); //marco UVM cho phép tạo create ghi đè tự động

virtual vending_machine_if vif; //virtual interface để kết nối với DUT
uvm_analysis_port#(vending_machine_transaction) ap; //analysis port dùng để gửi transaction đã thu thập sang scoreboard

function new(string name, uvm_component parent);
super.new(name,parent); //gọi constructor lớp cha
ap=new("ap",this); //tạo analysis port
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase); //gọi build_phase lớp cha
if(!uvm_config_db#(virtual vending_machine_if)::get(this,"","vif",vif))
`uvm_error("NOVIF","khong tim thay virtual interface") //lấy virtual interface từ config_db; nếu không có thì sẽ báo lỗi
endfunction

task run_phase(uvm_phase phase);
vending_machine_transaction tr; //biến tr lưu transaction 
forever begin
tr = vending_machine_transaction::type_id::create("tr",this);
// Chờ cạnh lên clock
if(count ==0) begin
repeat (2) @(posedge vif.clk);
end else begin
repeat (3) @(posedge vif.clk);
end 
#1
count++;
// Lấy dữ liệu output từ DUT vào transaction
tr.done = vif.done; //
tr.id_item = vif.id_item;
tr.value_coin = vif.value_coin;
tr.coin = vif.coin;
tr.product = vif.product;
tr.slot = vif.slot;
tr.coin_change = vif.coin_change;
tr.error_o = vif.error_o;
tr.current_state_o = vif.current_state_o;
tr.next_state_o = vif.next_state_o;
//in ra thông tin vừa thu được từ dut
`uvm_info("MONITOR", $sformatf("t=%0t | Thu duoc ket qua tu dut: product=%0d, error_o=%0d",$time, tr.product, tr.error_o), UVM_LOW)
// Gửi kết quả thu thập được đến scoreboard
ap.write(tr);
end
endtask
endclass

