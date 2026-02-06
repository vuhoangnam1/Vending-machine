// Kế thừa từ uvm_sequencer, chuyên dùng để điều phối các transaction kiểu vending_machine_transaction
class vending_machine_sequencer extends uvm_sequencer #(vending_machine_transaction);
`uvm_component_utils(vending_machine_sequencer) //marco UVM cho phép tạo create ghi đè tự động
function new(string name, uvm_component parent); 
super.new(name,parent);//gọi constructor cha (uvm_sequencer)
endfunction
endclass
