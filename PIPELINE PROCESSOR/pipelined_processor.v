reg [3:0]  EX_MEM_rd;
reg [3:0]  EX_MEM_opcode;

// Stage 1: Instruction Fetch
reg [3:0] PC;
always @(posedge clk or posedge rst) begin
if (rst) begin
PC <= 0;
IF_ID <= 0;
end else begin
IF_ID <= instr_mem[PC];
PC <= PC + 1;
end
end

// Stage 2: Instruction Decode
wire [3:0] opcode = IF_ID[15:12];
wire [3:0] rd = IF_ID[11:8];
wire [3:0] rs1 = IF_ID[7:4];
wire [3:0] rs2_addr = IF_ID[3:0];

reg [7:0] rs1_val, rs2_val;
always @(posedge clk) begin
rs1_val <= reg_file[rs1];
        rs2_val <= (opcode == 4'b0011) ? data_mem[rs2_addr] : reg_file[rs2_addr]; // load uses addr
        rs2_val <= (opcode == 4'b0011) ? data_mem[rs2_addr] : reg_file[rs2_addr]; // LOAD uses addr
ID_EX <= IF_ID;
end

// Stage 3: Execute
always @(posedge clk) begin
case (ID_EX[15:12])
            4'b0001: EX_MEM_val <= rs1_val + rs2_val; // ADD
            4'b0010: EX_MEM_val <= rs1_val - rs2_val; // SUB
            4'b0011: EX_MEM_val <= rs2_val;           // LOAD (from memory already read)
            default: EX_MEM_val <= 0;
        endcase
        EX_MEM_rd <= ID_EX[11:8]; // destination register
        EX_MEM_opcode <= ID_EX[15:12];
    end

    // Stage 4: Memory (write back)
    always @(posedge clk) begin
        case (EX_MEM_opcode)
            4'b0001, 4'b0010, 4'b0011: reg_file[EX_MEM_rd] <= EX_MEM_val;
            default: ; // NOP or undefined
        endcase
    end

endmodule
