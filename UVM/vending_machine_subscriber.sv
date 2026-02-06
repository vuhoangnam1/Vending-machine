class vending_machine_subscriber extends uvm_subscriber#(vending_machine_transaction);
`uvm_component_utils(vending_machine_subscriber)
// Biến lưu dữ liệu để dùng cho covergroup
logic coin;
logic [6:0]value_coin;
logic [3:0] id_item;
logic product;
logic [1:0] slot;
logic [6:0] coin_change;
logic [1:0] next_state_o;
logic [1:0] current_state_o;
logic error_o;
logic done;

//Kiểm tra function coverage
covergroup cvg;

//coverpoint cho next_state_o
cvgp_next_state_o: coverpoint next_state_o{
bins next_state_o_i ={[0:2]};
}

//coverpoint cho current_state_o
cvgp_current_state_o: coverpoint current_state_o{
bins current_state_o_i ={[0:2]};
}

//coverpoint cho coin
cvgp_coin: coverpoint coin{
bins coin_i ={[0:1]};
}

//coverpoint cho giá trị value_coin
cvgp_value_coin: coverpoint value_coin{
bins vl_coin ={[0:255]};
}

//coverpoint cho id_item
cvgp_id_item: coverpoint id_item{
bins id_item_i ={[0:15]};
}

//coverpoint cho product
cvgp_product: coverpoint product{
bins product_i ={[0:1]};
}

//coverpoint cho slot
cvgp_slot: coverpoint slot{
bins slot_i ={[0:1]};
}

//coverpoint cho coin_change
cvgp_coin_change: coverpoint coin_change{
bins vl_coin_change ={[0:255]};
}

//coverpoint cho id_item
cvgp_id_item: coverpoint id_item{
bins id_item_i ={[0:15]};
}

cvgp_error_o: coverpoint error_o{
bins error_o_i ={[0:1]};
}

//coverpoint cho rst
cvgp_done: coverpoint done{
bins done_i ={[0:1]};
}

//kiểm tra tổ hợp 
cross_all: cross cvgp_next_state_o, cvgp_current_state_o, cvgp_coin, cvgp_coin_change, cvgp_id_item, cvgp_id_item, cvgp_product, cvgp_slot, cvgp_done, cvgp_error_o  ;
endgroup

function new(string name = "vending_machine_subscriber", uvm_component parent);
super.new(name,parent);
cvg = new(); // khởi tạo covergroup
endfunction

function void write(vending_machine_transaction t);
// Lấy dữ liệu từ transaction
next_state_o=t.next_state_o;
current_state_o=t.current_state_o;
coin=t.coin;
value_coin=t.value_coin;
id_item=t.id_item;
product=t.product;
slot=t.slot;
coin_change=t.coin_change;
error_o=t.error_o;
done=t.done;

// Lấy mẫu coverage
cvg.sample();
endfunction
endclass
