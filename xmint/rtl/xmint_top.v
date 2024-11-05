/* verilator lint_off UNUSEDPARAM */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNDRIVEN */

module xmint_top
#(
    parameter WIDTH=32
) (
    // Clock and Reset
    input  logic                         clk_i,
    input  logic                         rst_ni,

    input  logic [31:0]                  boot_addr_i,

    // Instruction memory interface
    output logic                         instr_req_o,
    input  logic                         instr_gnt_i,
    input  logic                         instr_rvalid_i,
    output logic [31:0]                  instr_addr_o,
    input  logic [31:0]                  instr_rdata_i,
    input  logic [6:0]                   instr_rdata_intg_i,
    input  logic                         instr_err_i,

    // Data memory interface
    output logic                         data_req_o,
    input  logic                         data_gnt_i,
    input  logic                         data_rvalid_i,
    output logic                         data_we_o,
    output logic [3:0]                   data_be_o,
    output logic [31:0]                  data_addr_o,
    output logic [31:0]                  data_wdata_o,
    output logic [6:0]                   data_wdata_intg_o,
    input  logic [31:0]                  data_rdata_i,
    input  logic [6:0]                   data_rdata_intg_i,
    input  logic                         data_err_i,

    // CPU Control Signals
    input  logic [3:0]                   fetch_enable_i
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
