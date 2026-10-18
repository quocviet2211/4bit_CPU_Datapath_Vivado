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

// Opcode definitions
localparam ADD    = 4'h0;
localparam SUB    = 4'h1;
localparam AND_OP = 4'h2;
localparam OR_OP  = 4'h3;
localparam XOR_OP = 4'h4;
localparam NOT_OP = 4'h5;
localparam LDI    = 4'h6;
localparam MOV    = 4'h7;
localparam LOAD   = 4'h8;
localparam STORE  = 4'h9;
localparam JMP    = 4'hA;
localparam JZ     = 4'hB;

// ALU control definitions
localparam ALU_ADD  = 3'd0;
localparam ALU_SUB  = 3'd1;
localparam ALU_AND  = 3'd2;
localparam ALU_OR   = 3'd3;
localparam ALU_XOR  = 3'd4;
localparam ALU_NOT  = 3'd5;
localparam ALU_PASS = 3'd6;

always @(*) begin

    // Default: NOP
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
            // Keep all control signals disabled
        end

    endcase
end

endmodule
