// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// Ibex demo system top level for the Sonata board
module top_zcu104 (
  input wire  ref_clk_p,
  input wire  ref_clk_n,
  input nrst_btn,
  output logic [3:0] LED,
  output [ 3:0] DISP_CTRL,
  output logic ser0_tx,
  input  logic ser0_rx,

  input  logic tck_i,
  input  logic tms_i,
  input  logic td_i,
  output logic td_o,
  input         SPI_RX,
  output        SPI_TX,
  output        SPI_SCK
);
  parameter SRAMInitFile = "";

  logic mainclk_buf;
  logic clk_sys;
  logic rst_sys_n;
  logic [7:0] reset_counter;

  logic [4:0] nav_sw_n;
  logic [7:0] user_sw_n;

  logic pll_locked;
  logic rst_btn;



  // Switch inputs have pull-ups and switches pull to ground when on. Invert here so CPU sees 1 for
  // on and 0 for off.

  ibex_demo_system #(
    .GpiWidth(0),
    .GpoWidth(8),
    .PwmWidth(0),
    .SRAMInitFile(SRAMInitFile)
  ) u_ibex_demo_system (
     .gp_o     ({LED, DISP_CTRL}),
    .clk_sys_i(clk_sys),
    .rst_sys_ni(rst_sys_n),

    .uart_rx_i(ser0_rx),
    .uart_tx_o(ser0_tx),

    .spi_rx_i (SPI_RX),
    .spi_tx_o (SPI_TX),
    .spi_sck_o(SPI_SCK),

    .trst_ni(rst_sys_n),
    .tms_i,
    .tck_i,
    .td_i,
    .td_o
  );

  IBUFGDS #(
    .IOSTANDARD("LVDS"),
    .DIFF_TERM("FALSE"),
    .IBUF_LOW_PWR("FALSE")
  ) i_sysclk_iobuf (
    .I(ref_clk_p),
    .IB(ref_clk_n),
    .O(clk_sys)
  );

  assign rst_btn = ~nrst_btn;

  rst_ctrl u_rst_ctrl (
    .clk_i       (mainclk_buf),
    .pll_locked_i(pll_locked),
    .rst_btn_i   (rst_btn),
    .rst_no      (rst_sys_n)
  );
endmodule
