`timescale 1ns / 1ps

module Datapath #(
    parameter PC_W = 8,        // Program Counter
    parameter INS_W = 32,      // Instruction Width
    parameter RF_ADDRESS = 5,  // Register File Address
    parameter DATA_W = 32,     // Data WriteData
    parameter DM_ADDRESS = 9,  // Data Memory Address
    parameter ALU_CC_W = 4     // ALU Control Code Width
)(
    input clk,                 // CLK in Datapath figure
    input reset,               // Reset in Datapath figure
    input reg_write,           // RegWrite in Datapath figure
    input mem2reg,             // MemtoReg in Datapath figure
    input alu_src,             // ALUSrc in Datapath figure
    input mem_write,           // MemWrite in Datapath Figure
    input mem_read,            // MemRead in Datapath Figure
    input [ALU_CC_W-1:0] alu_cc, // ALUCC in Datapath Figure
    output [6:0] opcode,       // opcode in Datapath Figure
    output [6:0] funct7,       // Funct7 in Datapath Figure
    output [2:0] funct3,       // Funct3 in Datapath Figure
    output [DATA_W-1:0] alu_result // Datapath_Result in Datapath Figure
);


wire [PC_W-1:0] pc_out, pc_next;
wire [INS_W-1:0] instruction;
wire [DATA_W-1:0] imm_out;
wire [DATA_W-1:0] rs1_data, rs2_data;
wire [DATA_W-1:0] alu_in2;              //Wires used within to connect the submodule components together properly
wire [DATA_W-1:0] mem_read_data;
wire [DATA_W-1:0] write_back_data;
wire carry_out, overflow, zero;



assign pc_next = pc_out + 4;            //Adder design

// Flip-Flop / program Counter
FlipFlop PC (
    .clk(clk),
    .reset(reset),
    .d(pc_next),
    .q(pc_out)
);

// Instruction Memory
InstMem instmem (
    .addr(pc_out),
    .instruction(instruction)
);

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];



// Immediate Generator
ImmGen immgen (
    .InstCode(instruction),
    .ImmOut(imm_out)
);


    wire [RF_ADDRESS-1:0] rd_rg_wrt_wire;
    wire [RF_ADDRESS-1:0] rd_rg_addr_wire1; //Provided via lab manual
    wire [RF_ADDRESS-1:0] rd_rg_addr_wire2;
    
    assign rd_rg_wrt_wire    = instruction[11:7];
    assign rd_rg_addr_wire1  = instruction[19:15];
    assign rd_rg_addr_wire2  = instruction[24:20];
// Register File
RegFile regfile (
    .clk(clk),
    .reset(reset),
    .rg_rd_addr1(rd_rg_addr_wire1),
    .rg_rd_addr2(rd_rg_addr_wire2),
    .rg_wrt_addr(rd_rg_wrt_wire),
    .rg_wrt_en(reg_write),
    .rg_wrt_data(write_back_data),
    .rg_rd_data1(rs1_data),
    .rg_rd_data2(rs2_data)
);

// ALU Mux
Mux alu_mux (
    .S(alu_src),
    .D1(rs2_data),
    .D2(imm_out),
    .Y(alu_in2)
);

// ALU
ALU ALU_32 (
    .A_in(rs1_data),
    .B_in(alu_in2),
    .ALU_Sel(alu_cc),
    .ALU_Out(alu_result),
    .Carry_Out(carry_out),
    .Zero(zero),
    .Overflow(overflow)
);

// Data Memory
DataMem datamem (
    .addr(alu_result[DM_ADDRESS-1:0]),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .write_data(rs2_data),
    .read_data(mem_read_data)
);

// final Mux
Mux final_mux (
    .S(mem2reg),
    .D1(alu_result),
    .D2(mem_read_data),
    .Y(write_back_data)
);

endmodule // Datapath
