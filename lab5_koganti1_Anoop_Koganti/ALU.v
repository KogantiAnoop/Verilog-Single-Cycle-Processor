`timescale 1ns / 1ps

module ALU(
    input [31:0] A_in, B_in,        // ALU 32-bit inputs
    input [3:0] ALU_Sel,            // ALU 4-bit selection/control
    output [31:0] ALU_Out,          // ALU 32-bit result
    output reg Carry_Out,           // 1-bit Carry flag
    output Zero,                    // 1-bit Zero flag
    output reg Overflow = 1'b0      // 1-bit Overflow flag (initialized)
);

    reg [31:0] ALU_Result;
    reg [32:0] temp;
    reg [32:0] twos_com;

    assign ALU_Out = ALU_Result;       // Assign result to output
    assign Zero = (ALU_Result == 0);   // Zero flag

    always @(*) begin
        Overflow = 1'b0;
        Carry_Out = 1'b0;

        case(ALU_Sel)
            4'b0000: // Bitwise AND
                ALU_Result = A_in & B_in;

            4'b0001: // Bitwise OR
                ALU_Result = A_in | B_in;

            4'b0010: begin // Signed Addition
                ALU_Result = $signed(A_in) + $signed(B_in);
                temp = {1'b0, A_in} + {1'b0, B_in};
                Carry_Out = temp[32];
                if ((A_in[31] & B_in[31] & ~ALU_Result[31]) ||
                    (~A_in[31] & ~B_in[31] & ALU_Result[31]))
                    Overflow = 1'b1;
            end

            4'b0110: begin // Signed Subtraction
                ALU_Result = $signed(A_in) - $signed(B_in);
                twos_com = ~B_in + 1'b1;
                if ((A_in[31] & twos_com[31] & ~ALU_Result[31]) ||
                    (~A_in[31] & ~twos_com[31] & ALU_Result[31]))
                    Overflow = 1'b1;
            end

            4'b0111: // Set less than (signed)
                ALU_Result = ($signed(A_in) < $signed(B_in)) ? 32'd1 : 32'd0;

            4'b1100: // Bitwise NOR
                ALU_Result = ~(A_in | B_in);

            4'b1111: // Equality check
                ALU_Result = (A_in == B_in) ? 32'd1 : 32'd0;

            default: // Default = Add
                ALU_Result = A_in + B_in;
        endcase
    end

endmodule