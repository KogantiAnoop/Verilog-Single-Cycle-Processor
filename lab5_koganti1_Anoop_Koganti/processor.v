`timescale 1ns / 1ps

module processor (
    input clk, reset,
    output [31:0] Result   //Shown inputs and outputs in the diagram
);

// Internal wires from the diagram given in manual
wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;
wire [3:0] alu_cc;
wire [1:0] alu_op;
wire mem2reg;
wire mem_write;
wire mem_read; 
wire alu_src;
wire reg_write;

// Instantiate Controller to the module
Controller Controllerinst (
    .Opcode(opcode),
    .ALUSrc(alu_src),
    .MemtoReg(mem2reg),
    .RegWrite(reg_write),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .ALUOp(alu_op)
);

// Instantiate ALUController to the module
ALUController ALUControllerinst (
    .ALUOp(alu_op),
    .Funct7(funct7),
    .Funct3(funct3),
    .Operation(alu_cc)
);

// Instantiate Datapath to the module
Datapath datapathinst (
    .clk(clk),
    .reset(reset),
    .reg_write(reg_write),
    .mem2reg(mem2reg),
    .alu_src(alu_src),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .alu_cc(alu_cc),
    .opcode(opcode),
    .funct7(funct7),
    .funct3(funct3),
    .alu_result(Result)
);

endmodule // processor
