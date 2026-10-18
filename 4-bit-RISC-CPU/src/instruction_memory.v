// =====================================================================
// FILE: instruction_memory.v
// Stores the program: 16 words x 12 bits
// =====================================================================

module instruction_memory #(
    parameter PROGRAM_FILE = "program.mem"
)(
    input  [3:0]  address,
    output [11:0] instruction
);

    reg [11:0] mem [0:15];
    integer i;

    initial begin

        // Fill all memory locations with NOP
        for (i = 0; i < 16; i = i + 1)
            mem[i] = 12'hC00;

        // Load program
        $readmemh(PROGRAM_FILE, mem);

    end

    // Read instruction
    assign instruction = mem[address];

endmodule