`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/16 21:06:33
// Design Name:
// Module Name: PDM_decoder
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
module PDM_decoder(
        PDM_m_axis_tvalid,
        PDM_m_axis_tready, // input wire m_axis_tready
        PDM_m_axis_tdata,  // output wire [15 : 0] m_axis_tdata
        PDM_clk,
        PDM_in,
        clk_240M,
        rstn
    );

    input PDM_clk;
    input PDM_in;
    input clk_240M;
    input rstn;
    output PDM_m_axis_tvalid;            // output wire m_axis_tvalid
    input PDM_m_axis_tready;            // input wire m_axis_tready
    output [15 : 0] PDM_m_axis_tdata;   // output wire [15 : 0] m_axis_tdata

    wire [7 : 0]PDM_convert;

    wire [47 : 0]cic0_m_axis_data_tdata;
    wire cic0_m_axis_data_tvalid;

    wire [15 : 0]fir0_s_axis_data_tdata;
    wire fir0_s_axis_data_tvalid;
    wire [39 : 0] fir0_m_axis_data_tdata;
    wire fir0_m_axis_data_tvalid;
    wire fir0_m_axis_data_tready;

    //截位，使得动态范围最大且不失真
    assign fir0_s_axis_data_tdata  =  {cic0_m_axis_data_tdata[41],cic0_m_axis_data_tdata[35:21]};//5-6bit
    assign fir0_s_axis_data_tvalid =  cic0_m_axis_data_tvalid;
    assign PDM_m_axis_tvalid       =  fir0_m_axis_data_tvalid;// output wire m_axis_data_tvalid
    assign PDM_m_axis_tdata        =  {fir0_m_axis_data_tdata[33],fir0_m_axis_data_tdata[26:12]};  //5-6bit//coe 2 26:12 coe3 30:16
    assign fir0_m_axis_data_tready = PDM_m_axis_tready;

    PDM_convert PDM_convert_0(
                    .PDM_clk(PDM_clk),
                    .PDM_in(PDM_in),
                    .PDM_out(PDM_convert)
                );
    cic_compiler_0 cic0 (
                       .aclk(clk_240M),                                 // input wire aclk
                       .aresetn(rstn),                                  // input wire aresetn
                       .s_axis_data_tdata(PDM_convert),                 // input wire [1 : 0] s_axis_data_tdata
                       .s_axis_data_tvalid(1'b1),                       // input wire s_axis_data_tvalid
                       .s_axis_data_tready(),                           // output wire s_axis_data_tready
                       .m_axis_data_tdata(cic0_m_axis_data_tdata),      // output wire [15 : 0] m_axis_data_tdata
                       .m_axis_data_tvalid(cic0_m_axis_data_tvalid)     // output wire m_axis_data_tvalid
                   );

    fir_compiler_0 fir0 (
                       .aresetn(rstn),                                  // input wire aresetn
                       .aclk(clk_240M),                                 // input wire aclk
                       .s_axis_data_tvalid(fir0_s_axis_data_tvalid),    // input wire s_axis_data_tvalid
                       .s_axis_data_tready(),                           // output wire s_axis_data_tready
                       .s_axis_data_tdata(fir0_s_axis_data_tdata),      // input wire [15 : 0] s_axis_data_tdata
                       .m_axis_data_tvalid(fir0_m_axis_data_tvalid),    // output wire m_axis_data_tvalid
                       .m_axis_data_tdata(fir0_m_axis_data_tdata),      // output wire [39 : 0]  m_axis_data_tdata
                       .m_axis_data_tready(fir0_m_axis_data_tready)     // input wire m_axis_data_tready
                   );


endmodule

