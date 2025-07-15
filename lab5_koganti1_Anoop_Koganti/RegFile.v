` timescale 1 ns / 1 ps
// Module definition
module RegFile (
clk, reset, rg_wrt_en,
rg_wrt_addr,
rg_rd_addr1,
rg_rd_addr2,
rg_wrt_data,
rg_rd_data1,
rg_rd_data2
);
input [4:0] rg_rd_addr1, rg_rd_addr2, rg_wrt_addr; 
input [31:0] rg_wrt_data;
input rg_wrt_en, reset, clk;
output [31:0] rg_rd_data1, rg_rd_data2;

reg [31:0] register_file[0:31];
integer i;
always @ (posedge clk or posedge reset) //asynchronous reset signal with clock 
    begin
        if(reset)
        begin
            for(i = 0;i <32; i = i +1)
                register_file[i] <= 32'b0; //reset signal to reset all register file elements to 32'b0
     
        end
        else if(rg_wrt_en) 
           register_file[rg_wrt_addr] <= rg_wrt_data; //Change the value at a specific location to the wrt data
    end
    
assign rg_rd_data1 = register_file[rg_rd_addr1];
assign rg_rd_data2 = register_file[rg_rd_addr2]; //assigning the rd_data outputs to the register location values
// Define the input and output signals
// Define the Register File module behavior
endmodule // RegFile