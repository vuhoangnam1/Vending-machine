module vending_machine(
input logic clk,
input logic rst,
input logic coin,//có tiền nạp vào
input logic [3:0] id_item, //mã sản phẩm
input logic [6:0] value_coin, //số tiền nạp vào
output logic product, //sản phẩm
output logic [1:0] slot, //khe đựng sản phẩm
output logic [6:0] coin_change, //tiền thối lại
output logic error_o,//lỗi
output logic done, //xác nhận hoàn thành giao dịch
output logic [1:0] current_state_o, 
output logic [1:0] next_state_o
); 
logic [6:0] price; // giá sản phẩm
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
//xác định loại sản phẩm qua khe xuất
function logic [1:0] get_slot(input logic [3:0] id_item);
if(id_item<=5) 
get_slot =2'd1;
else 
get_slot =2'd2;
endfunction
typedef enum logic [1:0]{
wait_ordered=2'b00, // chờ nạp tiền
check_coin=2'b01, //kiểm tra điều kiện mua sản phẩm
respond_product=2'b10 //trả sản phẩm
} state_t;
state_t state;
state_t next_state;
assign current_state_o= state;
assign next_state_o= next_state;
//cập nhật trạng thái FSM
always_ff @(posedge clk or posedge rst) begin
if (rst) begin
state <= wait_ordered;
done <= 0;
end else begin
state <= next_state;

//gán done chỉ khi đang ở trạng thái respond_product
if (next_state == respond_product)
done <= 1;
else
done <= 0;
end
end
//khởi tạo các giá trị mặc định 
always_comb begin 
next_state =state; 
product=0;
coin_change=0;
error_o=0;
slot=0;
price =get_price(id_item);
case(state)
wait_ordered: begin //chờ người mua nạp tiền vào
if(coin==1)
next_state = check_coin; //khi đã nạp tiền vào máy sẽ kiểm tra số tiền
else
next_state = wait_ordered;
end
//trạng thái kiểm tra số tiền
check_coin: begin
if(value_coin >= price) begin //nếu đủ tiền sẽ trả sản phẩm vào ô tương ứng và tiền thối
product=1;
error_o=0;
coin_change = value_coin-price;
slot=get_slot(id_item);
end else begin // ngược lại sẽ không trả sản phẩm mà báo lỗi, hoàn trả toàn bộ số tiền nạp vào
product=0;
error_o=1;
coin_change = value_coin;
end
next_state=respond_product;//trả sản phẩm, tiền thối sau khi kiểm tra đủ hay thiếu tiền
end
//trạng thái trả sản phẩm 
respond_product: begin
next_state = wait_ordered; //trở lại trạng thái chờ
end
endcase
end
endmodule