// =====================================================================
// FILE: mux.v
// 2-input, 4-bit multiplexer.
// =====================================================================

module mux2 (
    input [3:0] d0,
    input [3:0] d1,
    input        sel,
    output [3:0] y
);

    assign y = (sel == 1'b1) ? d1 : d0;

endmodule