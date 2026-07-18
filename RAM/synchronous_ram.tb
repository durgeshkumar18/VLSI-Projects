// File: tb_synchronous_ram.v
`timescale 1ns / 1ps

module tb_synchronous_ram;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    // Signals
    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    // Instantiate the RAM
    synchronous_ram #(DATA_WIDTH, ADDR_WIDTH) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100MHz clock

    // Test Sequence
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_sunchronous_ram)
        $display("Starting RAM simulation...");
        
        we = 1; addr = 4'h2; din = 8'hAA; #10; // Write 0xAA at address 2
        we = 1; addr = 4'h4; din = 8'h55; #10; // Write 0x55 at address 4

        we = 0; addr = 4'h2; #10; // Read address 2
        $display("Read from addr 2 = %h", dout);

        addr = 4'h4; #10; // Read address 4
        $display("Read from addr 4 = %h", dout);

        addr = 4'h1; #10; // Read from an uninitialized address
        $display("Read from addr 1 = %h", dout);

        $finish;
    end
endmodule
