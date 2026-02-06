//kế thừa từ uvm_env dùng để gom agent và scoreboard
class vending_machine_environment extends uvm_env;
`uvm_component_utils(vending_machine_environment); //marco UVM cho phép tạo create ghi đè tự động
vending_machine_agent agn;
vending_machine_scoreboard scb; 
function new(string name,uvm_component parent);
super.new(name,parent); //gọi constructor lớp cha
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase); //gọi build_phase của lớp cha
agn = vending_machine_agent::type_id::create("agn",this); //tạo agent
scb = vending_machine_scoreboard::type_id::create("scb",this); //tạo scoreboard
sub = vending_machine_subscriber::type_id::create("sub",this); //tạo subscriber
endfunction
//analysis port của monitor trong agent đến analysis imp của scoreboard
//cho phép monitor gửi transaction tới scoreboard thông qua cơ chế write()
function void connect_phase(uvm_phase phase);
agn.ap.connect(scb.imp);
//cho phép monitor gửi transaction tới subscriber thông qua cơ chế write()
agn.ap.connect(sub.analysis_export);
endfunction
endclass
