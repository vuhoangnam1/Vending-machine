//kế thừa từ uvm_scoreboard dùng để kiểm tra kết quả DUT trả về có đúng hay không
class vending_machine_scoreboard extends uvm_scoreboard; 
`uvm_component_utils(vending_machine_scoreboard); //marco UVM cho phép tạo create ghi đè tự động
//analysis_imp cho phép scoreboard nhận transaction từ agent thông qua phương thức write()
uvm_analysis_imp#(vending_machine_transaction,vending_machine_scoreboard) imp; 
function new(string name = "vending_machine_scoreboard",uvm_component parent);
super.new(name,parent); //gọi constructor lớp cha
imp=new("imp",this); //khởi tạo analysis_imp để nhận transaction
endfunction

//giá sản phẩm theo ID 
 function logic [6:0] get_price(input logic [3:0] id_item); 
case(id_item)
1: get_price = 7'd5;
2: get_price = 7'd10;
3: get_price = 7'd15;
4: get_price = 7'd20;
5: get_price = 7'd25;
6: get_price = 7'd30;
7: get_price = 7'd35;
8: get_price = 7'd40;
9: get_price = 7'd45;
10: get_price = 7'd50;
default: get_price = 7'd0;
endcase
endfunction
//xác định khe xuất sản phẩm
function logic [1:0] get_slot(input logic [3:0] id_item);
if(id_item<=5) 
get_slot =2'd1;
else 
get_slot =2'd2;
endfunction
//gọi khi monitor gửi 1 transaction đến scoreboard để kiểm tra
function void write(vending_machine_transaction tr);
int expected_product_price;
int expected_product_slot;
//in ra thông báo khi scoreboard bắt đầu xử lý một transaction
//kiểm tra xem transaction từ monitor có thực sự tới được scoreboard hay không
`uvm_info("SCOREBOARD", $sformatf("t=%0t da vao ham write()", $time), UVM_LOW);
expected_product_price = get_price(tr.id_item); //giá tiền sản phẩm mong đợi
expected_product_slot = get_slot(tr.id_item); //khe xuất sản phẩm mong đợi
//in kết quả mong đợi
$display("[SCOREBOARD] | t=%0t | id: %0d | price: %0d | value_coin: %0d| slot: %0d | coin_change: %0d |coin: %0d",$time,tr.id_item, expected_product_price, tr.value_coin, expected_product_slot, tr.coin_change, tr.coin);
//Đã nạp tiền 
if(tr.coin) begin //1 
 //Giá không hợp lệ
 if(expected_product_price ==0) begin //2
 `uvm_info("SCOREBOARD",$sformatf("khong ton tai gia san pham"),UVM_LOW )
 end else begin //2
 `uvm_info("SCOREBOARD", $sformatf("gia san pham la %0d",expected_product_price), UVM_LOW)
	//Nếu đủ tiền mua hàng
	if(tr.value_coin >= expected_product_price) begin //3
	`uvm_info("SCOREBOARD", $sformatf("so tien thua la: %0d", tr.coin_change), UVM_LOW)
		//DUT trả sai kết quả //4
		if (tr.product != 1 || tr.coin_change != (tr.value_coin - expected_product_price) || tr.error_o != 0 ) begin //4
		`uvm_error("SCOREBOARD", $sformatf("product %0d coin_change %0d error_o %0d Cac gia tri dau ra sai!",tr.product, tr.coin_change, tr.error_o))
		end else begin //4
		`uvm_info("SCOREBOARD", $sformatf("product %0d  error_o %0d  Giao dich thanh cong so tien duoc hoan tra coin_change %0d",tr.product, tr.error_o, tr.coin_change), UVM_LOW)
		end
			//khe xuất
			if(tr.slot !== expected_product_slot) begin //4.5
			`uvm_error("SCOREBOARD", $sformatf("Sai khe xuat san pham! slot = %0d", tr.slot))
			end else begin //4.5
			`uvm_info("SCOREBOARD", $sformatf("khe xuat san pham slot la: %0d", tr.slot), UVM_LOW)
			end //4.5
	 end else begin //3
		if (tr.product != 0 || tr.coin_change != tr.value_coin  || tr.error_o != 1 )
		`uvm_error("SCOREBOARD", $sformatf("product %0d  coin_change %0d  error_o %0d  Cac gia tri dau ra sai!",tr.product, tr.coin_change, tr.error_o))
		else
		`uvm_info("SCOREBOARD", $sformatf("product %0d  error_o %0d  Giao dich khong thanh cong do khong du tien, so tien duoc hoan tra toan bo coin_change %0d",tr.product, tr.error_o, tr.coin_change), UVM_LOW)
	end //3
  end	//2
end else begin	//1
  //chưa nạp tiền
  if (tr.product != 0 || tr.coin_change != 0 )
  `uvm_error("SCOREBOARD", $sformatf("product %0d  coin_change %0d  khong nap tien nhung may xu li dau ra sai",tr.product, tr.coin_change))
	else
	`uvm_info("SCOREBOARD", $sformatf("product %0d  coin_change %0d  chua nap tien may tu choi giao dich",tr.product, tr.coin_change), UVM_LOW)
end //1
endfunction
endclass


