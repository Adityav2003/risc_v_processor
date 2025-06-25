
`include "/home/shivashankarb/class_assignments/riscv_design/riscv_cpu.v"
`include "/home/shivashankarb/class_assignments/riscv_design/instr_mem.v"
`include "/home/shivashankarb/class_assignments/riscv_design/data_mem.v"
`include "/home/shivashankarb/class_assignments/riscv_design/reset_ff.v" 
`include "/home/shivashankarb/class_assignments/riscv_design/reg_file.v" 
`include "/home/shivashankarb/class_assignments/riscv_design/mux4.v"
`include "/home/shivashankarb/class_assignments/riscv_design/mux3.v"
`include "/home/shivashankarb/class_assignments/riscv_design/mux2.v"
`include "/home/shivashankarb/class_assignments/riscv_design/main_decoder.v"
`include "/home/shivashankarb/class_assignments/riscv_design/imm_extend.v"
`include "/home/shivashankarb/class_assignments/riscv_design/datapath.v"
`include "/home/shivashankarb/class_assignments/riscv_design/controller.v"
`include "/home/shivashankarb/class_assignments/riscv_design/alu_decoder.v" 
`include "/home/shivashankarb/class_assignments/riscv_design/alu.v"
`include "/home/shivashankarb/class_assignments/riscv_design/adder.v"
module top_riscv_cpu (
    input         clk, reset,
    input         Ext_MemWrite,
    input  [31:0] Ext_WriteData, Ext_DataAdr,
    output        MemWrite,
    output [31:0] WriteData, DataAdr, ReadData,
    output [31:0] PC, Result
);

wire [31:0] Instr;
wire [31:0] DataAdr_rv32, WriteData_rv32;
wire        MemWrite_rv32;

// instantiate processor and memories
riscv_cpu rvcpu    (clk, reset, PC, Instr,
                    MemWrite_rv32, DataAdr_rv32,
                    WriteData_rv32, ReadData, Result);
instr_mem instrmem (PC, Instr);
data_mem  datamem  (clk, MemWrite,Instr [14:12], DataAdr, WriteData, ReadData);

assign MemWrite  = (Ext_MemWrite && reset) ? 1 : MemWrite_rv32;
assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr   = reset ? Ext_DataAdr : DataAdr_rv32;

endmodule
