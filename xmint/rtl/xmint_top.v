/* verilator lint_off UNUSEDPARAM */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */

module xmint_top
#(
    parameter WIDTH=32
) (
    // Clock and Reset
    input  wire                         clk_i,
    input  wire                         rst_ni,

    input  wire [31:0]                  boot_addr_i,

    // Instruction memory interface
    output wire                         instr_req_o,
    input  wire                         instr_gnt_i,
    input  wire                         instr_rvalid_i,
    output wire [31:0]                  instr_addr_o,
    input  wire [31:0]                  instr_rdata_i,
    input  wire [6:0]                   instr_rdata_intg_i,
    input  wire                         instr_err_i,

    // Data memory interface
    output wire                         data_req_o,
    input  wire                         data_gnt_i,
    input  wire                         data_rvalid_i,
    output wire                         data_we_o,
    output wire [3:0]                   data_be_o,
    output wire [31:0]                  data_addr_o,
    output wire [31:0]                  data_wdata_o,
    output wire [6:0]                   data_wdata_intg_o,
    input  wire [31:0]                  data_rdata_i,
    input  wire [6:0]                   data_rdata_intg_i,
    input  wire                         data_err_i,

    // CPU Control Signals
    input  wire [3:0]                   fetch_enable_i
);

    assign instr_req_o = 1'b0;
    assign instr_addr_o = 32'hBABECAFE;
    assign data_req_o = 1'b0;
    assign data_we_o = 1'b0;
    assign data_be_o = 4'b0000;
    assign data_addr_o = 32'hDEADBEEF;
    assign data_wdata_o = 32'hCAFEBABE;
    assign data_wdata_intg_o = 1'b0;

endmodule
