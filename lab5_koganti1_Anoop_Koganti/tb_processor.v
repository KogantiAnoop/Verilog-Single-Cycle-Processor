`timescale 1ns / 1ps

module tb_processor();

/** Clock & reset **/
reg clk, rst;
wire [31:0] tb_Result;

// Instantiate the processor
processor processor_inst (
    .clk(clk),
    .reset(rst),
    .Result(tb_Result)
);

// Clock generation
always begin
    #10;
    clk = ~clk;
end

// Reset sequence
initial begin
    clk = 0;
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;
end

// Required buy Professor requirements on lab
initial begin
    $dumpfile("test.vcd");
    $dumpvars;
end

// Test checker
integer point = 0;

always @(*) begin
    #20;
    if (tb_Result == 32'h00000000) // and
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000001) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000002) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000004) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000005) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000007) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000008) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h0000000b) // addi
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000003) // add
        point = point + 1;

    #20;
    if (tb_Result == 32'hfffffffe) // sub
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000000) // and
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000005) // or
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000001) // slt
        point = point + 1;

    #20;
    if (tb_Result == 32'hfffffff4) // nor
        point = point + 1;

    #20;
    if (tb_Result == 32'h000004D2) // andi
        point = point + 1;

    #20;
    if (tb_Result == 32'hfffff8d7) // ori
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000001) // slti
        point = point + 1;

    #20;
    if (tb_Result == 32'hfffffb2c) // nori
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000030) // sw
        point = point + 1;

    #20;
    if (tb_Result == 32'h00000030) // lw
        point = point + 1;

    $display("The number of correct test cases is: %d", point);
end

// End simulation after enough time
initial begin
    #430;
    $finish;
end

endmodule
