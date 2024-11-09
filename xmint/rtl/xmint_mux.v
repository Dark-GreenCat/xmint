module xmint_mux #(
    parameter N = 2,
    parameter MuxDataWidth = 32,
    localparam SelWidth = $clog2(N)
) (
    input [$clog2(N)-1:0] sel_i,
    input [MuxDataWidth*N-1:0] data_i,
    output [MuxDataWidth-1:0] data_o
);

    assign data_o = data_i[MuxDataWidth * sel_i +: MuxDataWidth];
endmodule