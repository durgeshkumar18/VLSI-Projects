
// File: fir_filter.v
module fir_filter #(
    parameter DATA_WIDTH = 8,
    parameter COEFF_WIDTH = 8,
    parameter TAPS = 4
)(
    input clk,
    input rst,
    input signed [DATA_WIDTH-1:0] x_in,
    output reg signed [DATA_WIDTH+COEFF_WIDTH+1:0] y_out
);

    // Example FIR Coefficients (h): Low-pass filter example
    parameter signed [COEFF_WIDTH-1:0] h [0:TAPS-1] = '{8'd3, 8'd5, 8'd5, 8'd3};

    // Delay Line (shift register)
    reg signed [DATA_WIDTH-1:0] x_reg [0:TAPS-1];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < TAPS; i = i + 1)
                x_reg[i] <= 0;
            y_out <= 0;
        end else begin
            // Shift input samples
            for (i = TAPS-1; i > 0; i = i - 1)
                x_reg[i] <= x_reg[i-1];
            x_reg[0] <= x_in;

            // Multiply-Accumulate
            y_out <= 0;
            for (i = 0; i < TAPS; i = i + 1)
                y_out <= y_out + x_reg[i] * h[i];
        end
    end
endmodule
