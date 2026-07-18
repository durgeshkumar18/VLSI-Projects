// File: tb_fir_filter.v
`timescale 1ns/1ps

module tb_fir_filter;

    parameter DATA_WIDTH = 8;
    parameter COEFF_WIDTH = 8;
    parameter TAPS = 4;

    reg clk;
    reg rst;
    reg signed [DATA_WIDTH-1:0] x_in;
    wire signed [DATA_WIDTH+COEFF_WIDTH+1:0] y_out;

    fir_filter #(DATA_WIDTH, COEFF_WIDTH, TAPS) uut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("fir_wave.vcd");
        $dumpvars(0, tb_fir_filter);

        rst = 1; x_in = 0;
        #10 rst = 0;

        // Input sequence
        x_in = 8'd1;  #10;
        x_in = 8'd2;  #10;
        x_in = 8'd3;  #10;
        x_in = 8'd4;  #10;
        x_in = 8'd5;  #10;
        x_in = 8'd6;  #10;
        x_in = 8'd0;  #10;
        x_in = 8'd0;  #10;

        #50;
        $finish;
    end
endmodule
