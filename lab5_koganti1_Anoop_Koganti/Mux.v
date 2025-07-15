`timescale 1ns / 1ps

module Mux (
    input S,
    input [31:0] D1,   //Declaring variables as inputs and outputs in module
    input [31:0] D2,
    output reg [31:0] Y);
    
    always @ (*)
    begin
    case(S)
    1'b0 : Y = D1;
    1'b1 : Y = D2;
    default: Y = 32'hXXXXXXXX;
    endcase
    end
endmodule