interface vending_machine_if;
logic clk;
logic rst;
logic coin;
logic [6:0]value_coin;
logic [3:0] id_item;
logic product;
logic [1:0] next_state_o;
logic [1:0] current_state_o;
logic [1:0] slot;
logic [6:0] coin_change;
logic error_o;
logic done;
endinterface
