//kế thừa từ uvm_driver, dùng để điều khiển DUT theo transaction kiểu vending_machine_transaction
class vending_machine_driver extends uvm_driver#(vending_machine_transaction);
`uvm_component_utils(vending_machine_driver); //marco UVM cho phép tạo create ghi đè tự động
virtual vending_machine_if vif; //virtual interface để kết nối với DUT
function new(string name = "vending_machine_driver", uvm_component parent);
super.new(name,parent); //gọi constructor lớp cha
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase); //gọi build_phase lớp cha
if(!uvm_config_db#(virtual vending_machine_if)::get(this,"","vif",vif))
`uvm_error("NOVIF", "khong tim thay virtual interface")  //lấy virtual interface từ config_db; nếu không có thì sẽ báo lỗi
endfunction

task run_phase(uvm_phase phase);
forever begin
vending_machine_transaction tr; //biến tr lưu transaction 
@(posedge vif.clk);// ngay lck=1 lần đầu tiên là cập nhật giá trị đầu vào ở wait_ordered gửi 
seq_item_port.get_next_item(tr);  // nhận transaction từ sequence
//in ra kiểm tra thông tin của transaction vừa nhận được từ sequence
`uvm_info("DRIVER", $sformatf("t=%0t |da nhan duoc transaction: id = %0d, value_coin = %0d, coin = %0d",$time, tr.id_item, tr.value_coin, tr.coin), UVM_LOW)
// Gửi tín hiệu nạp tiền và chọn sản phẩm
vif.value_coin <= tr.value_coin;
vif.id_item <= tr.id_item;
vif.coin  <= tr.coin;
repeat (2)@(posedge vif.clk); // tại vì có 3 trạng thái, phải delay 2 lần để vô trạng thái check_coin và respond_product
seq_item_port.item_done();  // báo đã gửi xong
end
endtask
endclass

