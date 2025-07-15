` timescale 1 ns / 1 ps
// Module definition
module FlipFlop ( clk , reset , d , q );

input clk,reset;
input [7:0] d;
output reg [7:0] q;
always @ (posedge clk)
    begin
        if(reset) // If reset is equal to 1, then the output can only be 0
                q <= 8'b0;
        else // Otherwise, the output is determined by the input d.
                q <= d;
    end
// Define input and output signals
// Define the D Flip flop module 's behaviour
endmodule // FlipFlop