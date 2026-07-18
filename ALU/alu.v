module ALU (
    input  [7:0] A,          // 8-bit input A
    input  [7:0] B,          // 8-bit input B
    input  [2:0] SEL,        // 3-bit select signal
    output reg [7:0] OUT     // 8-bit output
);

always @(*) begin
    case (SEL)
        3'b000: OUT = A + B;   // Addition
        3'b001: OUT = A - B;   // Subtraction
        3'b010: OUT = A & B;   // AND
        3'b011: OUT = A | B;   // OR
        3'b100: OUT = ~A;      // NOT
        default: OUT = 8'b00000000;
    endcase
end

endmodule
