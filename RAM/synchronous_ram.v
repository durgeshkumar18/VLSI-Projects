module synchronous_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input clk,
    input we, // Write Enable
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout
);

    // Memory Declaration: 2^ADDR_WIDTH locations
    reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;     // Write operation
        else
            dout <= mem[addr];    // Read operations 
    end
endmodule
