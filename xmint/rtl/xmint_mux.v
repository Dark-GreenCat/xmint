module xmint_mux #(
    parameter N = 3,         // Number of inputs (should be >= 1)
    parameter MUX_DATA_WIDTH = 32 // Bit-width of each input
) (
    input  wire [N-1:0][MUX_DATA_WIDTH-1:0] data, // Input data array
    input  wire [$clog2(N)-1:0] sel,           // Selector line (log2 of N)
    output reg [MUX_DATA_WIDTH-1:0] y               // Mux output
);
    localparam [$clog2(N)-1:0] SEL_MAX = $clog2(N)'(N - 1);

    always @(sel) begin
        if (sel < SEL_MAX) begin
            y = data[sel]; // Valid selector, output the selected data
        end else begin
            y = {MUX_DATA_WIDTH{1'b0}}; // Default case, zero output for invalid selector
        end
    end

endmodule