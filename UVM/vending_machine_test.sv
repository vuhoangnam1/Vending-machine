//kế thừa từ uvm_test, là nơi để gom env, sequence và bắt đầu mô phỏng
class vending_machine_test extends uvm_test;
`uvm_component_utils(vending_machine_test); //marco UVM cho phép tạo create ghi đè tự động
vending_machine_environment env;
vending_machine_sequence seq;
function new(string name,uvm_component parent);
super.new(name, parent); //gọi constructor lớp cha
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase); //gọi build_phase của lớp cha
env = vending_machine_environment::type_id::create("env",this); //tạo env
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this); //thông báo với UVM rằng test này đang thực thi, không kết thúc simulation
seq = vending_machine_sequence::type_id::create("seq",this); //Tạo một sequence (chuỗi test) có kiểu vending_machine_sequence
seq.start(env.agn.sqr); //khởi chạy sequence và kết nối vào sequencer bên trong agent.
phase.drop_objection(this);   
endtask
endclass

