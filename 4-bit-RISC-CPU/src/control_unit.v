`timescale 1ns / 1ps

module instruction_decoder (
    input      [3:0] opcode,
    output reg [2:0] alu_ctrl,
    output reg       alu_src_sel,
    output reg       wb_sel,
    output reg       reg_we,
    output reg       mem_we,
    output reg       zero_we,
    output reg       carry_we,
    output reg       is_jmp,
    output reg       is_jz
);

localparam ADD   = 4'h0;
localparam SUB   = 4'h1;
localparam AND_OP= 4'h2;
localparam OR_OP = 4'h3;
localparam XOR_OP= 4'h4;
localparam NOT_OP= 4'h5;
localparam LDI   = 4'h6;
localparam MOV   = 4'h7;
localparam LOAD  = 4'h8;
localparam STORE = 4'h9;
localparam JMP   = 4'hA;
localparam JZ    = 4'hB;

localparam ALU_ADD  = 3'd0;
localparam ALU_SUB  = 3'd1;
localparam ALU_AND  = 3'd2;
localparam ALU_OR   = 3'd3;
localparam ALU_XOR  = 3'd4;
localparam ALU_NOT  = 3'd5;
localparam ALU_PASS = 3'd6;

always @(*) begin
    alu_ctrl    = ALU_ADD;
    alu_src_sel = 1'b0;
    wb_sel      = 1'b0;
    reg_we      = 1'b0;
    mem_we      = 1'b0;
    zero_we     = 1'b0;
    carry_we    = 1'b0;
    is_jmp      = 1'b0;
    is_jz       = 1'b0;

    case (opcode)
        ADD: begin
            alu_ctrl = ALU_ADD;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
            carry_we = 1'b1;
        end

        SUB: begin
            alu_ctrl = ALU_SUB;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
            carry_we = 1'b1;
        end

        AND_OP: begin
            alu_ctrl = ALU_AND;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
        end

        OR_OP: begin
            alu_ctrl = ALU_OR;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
        end

        XOR_OP: begin
            alu_ctrl = ALU_XOR;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
        end

        NOT_OP: begin
            alu_ctrl = ALU_NOT;
            reg_we   = 1'b1;
            zero_we  = 1'b1;
        end

        LDI: begin
            alu_ctrl    = ALU_PASS;
            alu_src_sel = 1'b1;
            reg_we      = 1'b1;
        end

        MOV: begin
            alu_ctrl = ALU_PASS;
            reg_we   = 1'b1;
        end

        LOAD: begin
            alu_ctrl    = ALU_PASS;
            alu_src_sel = 1'b1;
            wb_sel      = 1'b1;
            reg_we      = 1'b1;
        end

        STORE: begin
            alu_ctrl    = ALU_PASS;
            alu_src_sel = 1'b1;
            mem_we      = 1'b1;
        end

        JMP: begin
            is_jmp = 1'b1;
        end

        JZ: begin
            is_jz = 1'b1;
        end

        default: begin
            // NOP: do nothing
        end
    endcase
end

endmodule


module branch_unit (
    input  is_jmp,
    input  is_jz,
    input  zero_flag,
    output reg pc_sel,
    output     flush
);

always @(*) begin
    if (is_jmp)
        pc_sel = 1'b1;
    else if (is_jz && zero_flag)
        pc_sel = 1'b1;
    else
        pc_sel = 1'b0;
end

assign flush = pc_sel;

endmodule


module control_unit (
    input      [3:0] opcode,

    output     [2:0] alu_ctrl,
    output           alu_src_sel,
    output           wb_sel,
    output           reg_we,
    output           mem_we,
    output           zero_we,
    output           carry_we,
    output           is_jmp,
    output           is_jz,

    input            ex_is_jmp,
    input            ex_is_jz,
    input            zero_flag,

    output           pc_sel,
    output           flush
);

instruction_decoder DECODER (
    .opcode      (opcode),
    .alu_ctrl    (alu_ctrl),
    .alu_src_sel (alu_src_sel),
    .wb_sel      (wb_sel),
    .reg_we      (reg_we),
    .mem_we      (mem_we),
    .zero_we     (zero_we),
    .carry_we    (carry_we),
    .is_jmp      (is_jmp),
    .is_jz       (is_jz)
);

branch_unit BRANCH (
    .is_jmp    (ex_is_jmp),
    .is_jz     (ex_is_jz),
    .zero_flag (zero_flag),
    .pc_sel    (pc_sel),
    .flush     (flush)
);

endmodule
