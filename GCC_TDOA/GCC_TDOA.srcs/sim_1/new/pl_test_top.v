`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/27 20:11:42
// Design Name:
// Module Name: pl_test_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module pl_test_top(
        PDM_clk,
        PDM_in,
        clk,
        rstn);
    output PDM_clk;
    input PDM_in;
    input clk;
    input rstn;

    wire clk_240M;
    wire PDM_m_axis_tvalid_1;
    wire PDM_m_axis_tready_1;
    wire [15 : 0] PDM_m_axis_tdata_1;

    clk_wiz_0 clk_wiz_0
              (
                  // Clock out ports
                  .clk_out1(clk_240M),     // output clk_out1
                  // Status and control signals
                  .resetn(rstn), // input resetn
                  // Clock in ports
                  .clk_in1(clk));

    clk_div50 clk_div50_0(
                  .clk_div50(PDM_clk),
                  .clk_in(clk_240M),
                  .rstn(rstn));

    PDM_decoder PDM_decoder_1(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_1),
                    .PDM_m_axis_tready(PDM_m_axis_tready_1), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_1), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );
    wire enframe_m_axis_tvalid_1;
    wire [15:0]enframe_m_axis_tdata_1;
    wire enframe_m_axis_tlast_1;
    wire enframe_m_axis_tready_1;
    enframe enframe_1( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_1),
                       .enframe_s_axis_tready(PDM_m_axis_tready_1),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_1),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_1),
                       .enframe_m_axis_tready(enframe_m_axis_tready_1),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_1),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_1)
                     );

    addwindow addwindow_1(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_1),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_1),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_1),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_1),

                          .addwindow_m_axis_tvalid(),
                          .addwindow_m_axis_tdata(),
                          .addwindow_m_axis_tlast(),
                          .addwindow_m_axis_tready(1)  // input wire m_axis_tready
                         );

endmodule
