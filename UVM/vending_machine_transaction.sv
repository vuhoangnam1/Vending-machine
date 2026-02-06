class vending_machine_transaction extends uvm_sequence_item;//transaction kế thừa từ sequence_item để dùng trong sequence
rand bit [6:0] value_coin; 
rand bit [3:0] id_item;
bit product;
bit [1:0] slot;
bit [6:0] coin_change;
bit coin;
bit error_o;
bit done;
bit [1:0] current_state_o;
bit [1:0] next_state_o;
//tầm trị của mã sản phẩm và giá trị tiền nạp vào
constraint valid {
 id_item inside {[1:10]};
 value_coin inside {[0:100]};
 }
`uvm_object_utils(vending_machine_transaction) //marco UVM cho phép tạo create ghi đè tự động
function new(string name = "vending_machine_transaction");//constructor với tên mặc định
super.new(name);//gọi constructor lớp cha
endfunction
endclass
