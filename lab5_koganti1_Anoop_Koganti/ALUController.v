`timescale 1ns / 1ps

// Module definition
module ALUController (
    ALUOp,
    Funct7,
    Funct3,
    Operation
);

// Define the input and output signals
input [1:0] ALUOp;
input [6:0] Funct7;
input [2:0] Funct3;
output [3:0] Operation;

// Define the ALUController module's behavior
assign Operation[0] = ((Funct3 == 3'b110) || ((Funct3 == 3'b010) && (ALUOp[0] == 1'b0))) ? 1'b1 : 1'b0;
// Bit 1 assignment ^
assign Operation[1] = ((Funct3 == 3'b010) || (Funct3 == 3'b000)) ? 1'b1 : 1'b0;
// Bit 2 assignment ^
assign Operation[2] = ((Funct3 == 3'b100) ||((Funct3 == 3'b010) && (ALUOp[0] == 1'b0)) || ((Funct7[5] == 1'b1) && (Funct3 == 3'b000) && (ALUOp[1] == 1'b1))) ? 1'b1 : 1'b0;
// Bit 3 assignment ^
assign Operation[3] = (Funct3 == 3'b100) ? 1'b1 : 1'b0;
// Bit 4 assignment ^
endmodule // ALUController
