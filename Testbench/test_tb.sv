module test_tb;
logic clk; 
logic rst;
logic [1:0] next_state_o;
logic [1:0] current_state_o;
logic [3:0] id_item;
logic [6:0] value_coin;
logic coin;
logic product;
logic [6:0] coin_change;
logic error_o;
logic done;
logic [1:0] slot;
logic [6:0] price;
vending_machine dut (
.clk(clk), 
.rst(rst),
.next_state_o(next_state_o),
.current_state_o(current_state_o),
.id_item(id_item),
.value_coin(value_coin),
.product(product),
.coin_change(coin_change),
.error_o(error_o),
.done(done),
.slot(slot),
.coin(coin)
);

// Clock
always #5 clk = ~clk;

 // Hàm tính giá
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

initial begin
clk = 0; 
rst = 1;
#12 rst = 0;
repeat (5) begin
// random 
id_item = $urandom_range(1, 10);
value_coin = $urandom_range(0, 50);
price = get_price(id_item);
if(id_item <= 3)
coin=0;
else
coin=1;
#10; 
$display("\n t=%0t | id_item=%0d | value_coin=%0d | price=%0d | coin=%0d",$time,id_item, value_coin, price, coin);           
// Kiểm tra logic DUT
if(coin) begin
 if(price ==0) begin
 $display("gia tri san pham khong ton tai");
 end else begin
 $display("gia san pham la %0d",price);
	if(value_coin >= price) begin
	 if (product != 1 || coin_change != (value_coin - price) || error_o != 0 )
    $display("product %0d | coin_change %0d | error_o %0d | Cac gia tri dau ra sai.",product,coin_change,error_o);
	 else
	 $display("product %0d | error_o %0d | Giao dich thanh cong, so tien duoc hoan tra coin_change %0d",product,error_o,coin_change);
	 end else begin
	 if (product != 0 || coin_change != value_coin  || error_o != 1 )
    $display("product %0d | coin_change %0d | error_o %0d | Cac gia tri dau ra sai.",product,coin_change,error_o);
	 else
	 $display("product %0d | error_o %0d | Giao dich khong thanh cong do khong du tien, so tien duoc hoan tra toan bo coin_change %0d.",product,error_o,coin_change);
	 end //  if value_coin >= price
 end //  if price == 0
			
end else begin
 if (product != 0 || coin_change != 0 )
 $display("product %0d | coin_change %0d | khong nap tien nhung may xu li dau ra sai.",product,coin_change);
 else
 $display("product %0d | coin_change %0d | chua nap tien may tu choi giao dich.",product,coin_change);
end
 #20; 
end // end của repeat
  $stop;

end //end của inital
endmodule
