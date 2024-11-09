`timescale 1ns / 1ps

module tb_xmint_mux;

    // Parameters for the multiplexer
    parameter N = 4;
    parameter MUX_DATA_WIDTH = 8;

    // Testbench signals
    reg [(N*MUX_DATA_WIDTH)-1:0] in;  // Combined input bus
    reg [$clog2(N)-1:0] sel;          // Select signal
    wire [MUX_DATA_WIDTH-1:0] out;    // Output of the mux

    // Instantiate the multiplexer
    xmint_mux #(.N(N), .MuxDataWidth(MUX_DATA_WIDTH)) uut (
        .sel_i(sel),
        .data_i(in),
        .data_o(out)
    );

    initial begin
        // Enable waveform dumping for Verilator
        $dumpfile("tb_xmint_mux.vcd");
        $dumpvars(0, tb_xmint_mux);

        // Test case 1: Set each input with distinct values
        in = {8'hAA, 8'hBB, 8'hCC, 8'hDD}; // in0 = 0xAA, in1 = 0xBB, in2 = 0xCC, in3 = 0xDD

        // Test selecting each input
        sel = 2'd0; #10; // Select in0 (0xAA)
        $display("sel=%d, out=%h", sel, out); // Expected out = 0xAA

        sel = 2'd1; #10; // Select in1 (0xBB)
        $display("sel=%d, out=%h", sel, out); // Expected out = 0xBB

        sel = 2'd2; #10; // Select in2 (0xCC)
        $display("sel=%d, out=%h", sel, out); // Expected out = 0xCC

        sel = 2'd3; #10; // Select in3 (0xDD)
        $display("sel=%d, out=%h", sel, out); // Expected out = 0xDD

        // End the test
        $finish;
    end

endmodule
