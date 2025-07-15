    `timescale 1ns / 1ps
// Module definition
module DataMem ( MemRead , MemWrite , addr , write_data , read_data );
// Define I / O ports
input [8:0] addr;
input MemRead, MemWrite;
input [31:0] write_data;
output reg [31:0] read_data;
reg [31:0] data_mem [0:127];

integer i;
initial
    begin
    for(i =0; i <128;i = i+1)  // Initialize all the data memory elements to 32'b0
        data_mem[i] = 32'b0;
    
    end
    
    
always @(*)
begin
    if(MemWrite == 1)
        data_mem[addr[8:2]] = write_data; //If memWrite is equal to true, then change the value at a specified address to the write_data value.
end
always @(*)
begin
    if(MemRead == 1)                        // if memRead is true, then provide a value to the output, read_data from the address specified.
        read_data = data_mem[addr[8:2]];
    else
        read_data = 32'hZZZZ; //otherwise, confirm it as a high impedence/undeclared value.
end                         
// Describe data_mem behavior
endmodule // data_mem