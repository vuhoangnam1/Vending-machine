//kế thừa từ uvm_sequence kiểu dữ liệu vending_machine_transaction, là nơi tạo và điều khiển các transaction sẽ gửi đến DUT
class vending_machine_sequence extends uvm_sequence#(vending_machine_transaction);
`uvm_object_utils(vending_machine_sequence) //marco UVM cho phép tạo create ghi đè tự động
function new(string name="vending_machine_sequence");
super.new(name); //gọi constructor lớp cha
endfunction
//task chính thực thi nội dung của sequence, dùng để tạo và gửi transaction
task body();
forever begin
vending_machine_transaction tr; //biến tr lưu transaction 
tr= vending_machine_transaction::type_id::create("tr"); //tạo transaction
assert(tr.randomize()); //gán giá trị ngẫu nhiện cho id_item và value_coin (đã khai báo rand trong transaction)
//các trường hợp nạp tiền ứng theo id
if (tr.id_item <= 3)
tr.coin = 0;
else
tr.coin = 1;
start_item(tr); //báo sẵn sàng truyền transaction cho driver
finish_item(tr); //báo cho driver đã hoàn tất truyền transaction 
end
endtask
endclass

