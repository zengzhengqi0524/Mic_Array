`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/18 16:52:46
// Design Name:
// Module Name: GCC_PHAT_9MIC
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
module GCC_PHAT_9MIC(
        PDM_in_1,
        PDM_in_2,
        PDM_in_3,
        PDM_in_4,
        PDM_in_5,
        PDM_in_6,
        PDM_in_7,
        PDM_in_8,
        PDM_in_ref,
        PDM_clk,
        clk_240M,
        rstn,
        GCC_PHAT_m_axis_tvalid,
        GCC_PHAT_m_axis_tdata
    );
    //---------------------------------------------------------------------------
    //--	符号常量
    //---------------------------------------------------------------------------
    //parameter framelength = 1023;
    //---------------------------------------------------------------------------
    //--	外部端口声明
    //---------------------------------------------------------------------------
    input PDM_in_1;
    input PDM_in_2;
    input PDM_in_3;
    input PDM_in_4;
    input PDM_in_5;
    input PDM_in_6;
    input PDM_in_7;
    input PDM_in_8;
    input PDM_in_ref;
    input clk_240M;
    input rstn;
    output PDM_clk;

    output wire GCC_PHAT_m_axis_tvalid;
    output wire [15:0]GCC_PHAT_m_axis_tdata;

    //---------------------------------------------------------------------------
    //--	内部端口声明
    //---------------------------------------------------------------------------
    wire PDM_m_axis_tvalid_1;
    wire PDM_m_axis_tready_1;
    wire [15 : 0]PDM_m_axis_tdata_1;
    wire PDM_m_axis_tvalid_2;
    wire PDM_m_axis_tready_2;
    wire [15 : 0]PDM_m_axis_tdata_2;
    wire PDM_m_axis_tvalid_3;
    wire PDM_m_axis_tready_3;
    wire [15 : 0]PDM_m_axis_tdata_3;
    wire PDM_m_axis_tvalid_4;
    wire PDM_m_axis_tready_4;
    wire [15 : 0]PDM_m_axis_tdata_4;
    wire PDM_m_axis_tvalid_5;
    wire PDM_m_axis_tready_5;
    wire [15 : 0]PDM_m_axis_tdata_5;
    wire PDM_m_axis_tvalid_6;
    wire PDM_m_axis_tready_6;
    wire [15 : 0]PDM_m_axis_tdata_6;
    wire PDM_m_axis_tvalid_7;
    wire PDM_m_axis_tready_7;
    wire [15 : 0]PDM_m_axis_tdata_7;
    wire PDM_m_axis_tvalid_8;
    wire PDM_m_axis_tready_8;
    wire [15 : 0]PDM_m_axis_tdata_8;
    wire PDM_m_axis_tvalid_ref;
    wire PDM_m_axis_tready_ref;
    wire [15 : 0]PDM_m_axis_tdata_ref;

    wire enframe_m_axis_tvalid_1;
    wire enframe_m_axis_tlast_1;
    wire enframe_m_axis_tready_1;
    wire [15:0]enframe_m_axis_tdata_1;
    wire enframe_m_axis_tvalid_2;
    wire enframe_m_axis_tlast_2;
    wire enframe_m_axis_tready_2;
    wire [15:0]enframe_m_axis_tdata_2;
    wire enframe_m_axis_tvalid_3;
    wire enframe_m_axis_tlast_3;
    wire enframe_m_axis_tready_3;
    wire [15:0]enframe_m_axis_tdata_3;
    wire enframe_m_axis_tvalid_4;
    wire enframe_m_axis_tlast_4;
    wire enframe_m_axis_tready_4;
    wire [15:0]enframe_m_axis_tdata_4;
    wire enframe_m_axis_tvalid_5;
    wire enframe_m_axis_tlast_5;
    wire enframe_m_axis_tready_5;
    wire [15:0]enframe_m_axis_tdata_5;
    wire enframe_m_axis_tvalid_6;
    wire enframe_m_axis_tlast_6;
    wire enframe_m_axis_tready_6;
    wire [15:0]enframe_m_axis_tdata_6;
    wire enframe_m_axis_tvalid_7;
    wire enframe_m_axis_tlast_7;
    wire enframe_m_axis_tready_7;
    wire [15:0]enframe_m_axis_tdata_7;
    wire enframe_m_axis_tvalid_8;
    wire enframe_m_axis_tlast_8;
    wire enframe_m_axis_tready_8;
    wire [15:0]enframe_m_axis_tdata_8;
    wire enframe_m_axis_tvalid_ref;
    wire enframe_m_axis_tlast_ref;
    wire enframe_m_axis_tready_ref;
    wire [15:0]enframe_m_axis_tdata_ref;

    wire addwindow_m_axis_tvalid_1;
    wire addwindow_m_axis_tlast_1;
    wire addwindow_m_axis_tready_1;
    wire [15:0]addwindow_m_axis_tdata_1;
    wire addwindow_m_axis_tvalid_2;
    wire addwindow_m_axis_tlast_2;
    wire addwindow_m_axis_tready_2;
    wire [15:0]addwindow_m_axis_tdata_2;
    wire addwindow_m_axis_tvalid_3;
    wire addwindow_m_axis_tlast_3;
    wire addwindow_m_axis_tready_3;
    wire [15:0]addwindow_m_axis_tdata_3;
    wire addwindow_m_axis_tvalid_4;
    wire addwindow_m_axis_tlast_4;
    wire addwindow_m_axis_tready_4;
    wire [15:0]addwindow_m_axis_tdata_4;
    wire addwindow_m_axis_tvalid_5;
    wire addwindow_m_axis_tlast_5;
    wire addwindow_m_axis_tready_5;
    wire [15:0]addwindow_m_axis_tdata_5;
    wire addwindow_m_axis_tvalid_6;
    wire addwindow_m_axis_tlast_6;
    wire addwindow_m_axis_tready_6;
    wire [15:0]addwindow_m_axis_tdata_6;
    wire addwindow_m_axis_tvalid_7;
    wire addwindow_m_axis_tlast_7;
    wire addwindow_m_axis_tready_7;
    wire [15:0]addwindow_m_axis_tdata_7;
    wire addwindow_m_axis_tvalid_8;
    wire addwindow_m_axis_tlast_8;
    wire addwindow_m_axis_tready_8;
    wire [15:0]addwindow_m_axis_tdata_8;
    wire addwindow_m_axis_tvalid_ref;
    wire addwindow_m_axis_tlast_ref;
    wire addwindow_m_axis_tready_ref;
    wire [15:0]addwindow_m_axis_tdata_ref;
    //---------------------------------------------------------------------------
    //--	逻辑功能实现
    //---------------------------------------------------------------------------
    clk_div50 clk_div50_0(
                  .clk_div50(PDM_clk),
                  .clk_in(clk_240M),
                  .rstn(rstn));

    //PDM_decoder
    PDM_decoder PDM_decoder_1(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_1),
                    .PDM_m_axis_tready(PDM_m_axis_tready_1), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_1), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_1),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_2(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_2),
                    .PDM_m_axis_tready(PDM_m_axis_tready_2), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_2), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_2),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_3(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_3),
                    .PDM_m_axis_tready(PDM_m_axis_tready_3), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_3), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_3),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_4(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_4),
                    .PDM_m_axis_tready(PDM_m_axis_tready_4), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_4), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_4),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_5(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_5),
                    .PDM_m_axis_tready(PDM_m_axis_tready_5), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_5), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_5),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_6(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_6),
                    .PDM_m_axis_tready(PDM_m_axis_tready_6), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_6), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_6),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_7(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_7),
                    .PDM_m_axis_tready(PDM_m_axis_tready_7), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_7), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_7),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_8(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_8),
                    .PDM_m_axis_tready(PDM_m_axis_tready_8), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_8), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_8),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_ref(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_ref),
                    .PDM_m_axis_tready(PDM_m_axis_tready_ref), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_ref), // output wire [15 : 0] m_axis_tdata
                    .PDM_in(PDM_in_ref),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    //enframe
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

    enframe enframe_2( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_2),
                       .enframe_s_axis_tready(PDM_m_axis_tready_2),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_2),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_2),
                       .enframe_m_axis_tready(enframe_m_axis_tready_2),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_2),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_2)
                     );

    enframe enframe_3( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_3),
                       .enframe_s_axis_tready(PDM_m_axis_tready_3),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_3),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_3),
                       .enframe_m_axis_tready(enframe_m_axis_tready_3),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_3),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_3)
                     );

    enframe enframe_4( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_4),
                       .enframe_s_axis_tready(PDM_m_axis_tready_4),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_4),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_4),
                       .enframe_m_axis_tready(enframe_m_axis_tready_4),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_4),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_4)
                     );

    enframe enframe_5( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_5),
                       .enframe_s_axis_tready(PDM_m_axis_tready_5),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_5),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_5),
                       .enframe_m_axis_tready(enframe_m_axis_tready_5),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_5),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_5)
                     );

    enframe enframe_6( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_6),
                       .enframe_s_axis_tready(PDM_m_axis_tready_6),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_6),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_6),
                       .enframe_m_axis_tready(enframe_m_axis_tready_6),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_6),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_6)
                     );

    enframe enframe_7( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_7),
                       .enframe_s_axis_tready(PDM_m_axis_tready_7),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_7),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_7),
                       .enframe_m_axis_tready(enframe_m_axis_tready_7),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_7),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_7)
                     );

    enframe enframe_8( .rstn(rstn),
                       .clk_240M(clk_240M),
                       .enframe_s_axis_tvalid(PDM_m_axis_tvalid_8),
                       .enframe_s_axis_tready(PDM_m_axis_tready_8),
                       .enframe_s_axis_tdata(PDM_m_axis_tdata_8),
                       .enframe_m_axis_tvalid(enframe_m_axis_tvalid_8),
                       .enframe_m_axis_tready(enframe_m_axis_tready_8),
                       .enframe_m_axis_tdata(enframe_m_axis_tdata_8),
                       .enframe_m_axis_tlast(enframe_m_axis_tlast_8)
                     );

    enframe enframe_ref( .rstn(rstn),
                         .clk_240M(clk_240M),
                         .enframe_s_axis_tvalid(PDM_m_axis_tvalid_ref),
                         .enframe_s_axis_tready(PDM_m_axis_tready_ref),
                         .enframe_s_axis_tdata(PDM_m_axis_tdata_ref),
                         .enframe_m_axis_tvalid(enframe_m_axis_tvalid_ref),
                         .enframe_m_axis_tready(enframe_m_axis_tready_ref),
                         .enframe_m_axis_tdata(enframe_m_axis_tdata_ref),
                         .enframe_m_axis_tlast(enframe_m_axis_tlast_ref)
                       );

    wire endcheck_flag;
    endcheck endcheck_0(
                 .clk_240M(clk_240M),                                        
                 .rstn(rstn),
                 .endcheck_s_axis_tvalid(enframe_m_axis_tvalid_ref),
                 .endcheck_s_axis_tdata(enframe_m_axis_tdata_ref),
                 .endcheck_s_axis_tlast(enframe_m_axis_tlast_ref),
                 .endcheck_flag(endcheck_flag)
             );


    //addwindow
    addwindow addwindow_1(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_1),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_1),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_1),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_1),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_1),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_1),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_1),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_1)
                         );

    addwindow addwindow_2(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_2),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_2),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_2),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_2),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_2),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_2),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_2),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_2)
                         );

    addwindow addwindow_3(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_3),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_3),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_3),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_3),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_3),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_3),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_3),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_3)
                         );

    addwindow addwindow_4(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_4),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_4),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_4),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_4),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_4),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_4),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_4),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_4)
                         );

    addwindow addwindow_5(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_5),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_5),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_5),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_5),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_5),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_5),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_5),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_5)
                         );

    addwindow addwindow_6(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_6),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_6),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_6),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_6),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_6),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_6),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_6),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_6)
                         );

    addwindow addwindow_7(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_7),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_7),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_7),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_7),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_7),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_7),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_7),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_7)
                         );

    addwindow addwindow_8(.rstn(rstn),
                          .clk_240M(clk_240M),
                          .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_8),
                          .addwindow_s_axis_tready(enframe_m_axis_tready_8),
                          .addwindow_s_axis_tdata(enframe_m_axis_tdata_8),
                          .addwindow_s_axis_tlast(enframe_m_axis_tlast_8),
                          .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_8),
                          .addwindow_m_axis_tdata(addwindow_m_axis_tdata_8),
                          .addwindow_m_axis_tlast(addwindow_m_axis_tlast_8),
                          .addwindow_m_axis_tready(addwindow_m_axis_tready_8)
                         );

    addwindow addwindow_ref(.rstn(rstn),
                            .clk_240M(clk_240M),
                            .addwindow_s_axis_tvalid(enframe_m_axis_tvalid_ref),
                            .addwindow_s_axis_tready(enframe_m_axis_tready_ref),
                            .addwindow_s_axis_tdata(enframe_m_axis_tdata_ref),
                            .addwindow_s_axis_tlast(enframe_m_axis_tlast_ref),
                            .addwindow_m_axis_tvalid(addwindow_m_axis_tvalid_ref),
                            .addwindow_m_axis_tdata(addwindow_m_axis_tdata_ref),
                            .addwindow_m_axis_tlast(addwindow_m_axis_tlast_ref),
                            .addwindow_m_axis_tready(addwindow_m_axis_tready_ref)
                           );




    GCC_PHAT_serial GCC_PHAT_serial_1(
                        .clk_240M(clk_240M),
                        .rstn(rstn),
                        .parallel_s_axis_tvalid_1(addwindow_m_axis_tvalid_1 && endcheck_flag),
                        .parallel_s_axis_tlast_1(addwindow_m_axis_tlast_1 && endcheck_flag),
                        .parallel_s_axis_tdata_1(addwindow_m_axis_tdata_1),
                        .parallel_s_axis_tready_1(addwindow_m_axis_tready_1),

                        .parallel_s_axis_tvalid_2(addwindow_m_axis_tvalid_2 && endcheck_flag),
                        .parallel_s_axis_tlast_2(addwindow_m_axis_tlast_2 && endcheck_flag),
                        .parallel_s_axis_tdata_2(addwindow_m_axis_tdata_2),
                        .parallel_s_axis_tready_2(addwindow_m_axis_tready_2),

                        .parallel_s_axis_tvalid_3(addwindow_m_axis_tvalid_3 && endcheck_flag),
                        .parallel_s_axis_tlast_3(addwindow_m_axis_tlast_3 && endcheck_flag),
                        .parallel_s_axis_tdata_3(addwindow_m_axis_tdata_3),
                        .parallel_s_axis_tready_3(addwindow_m_axis_tready_3),

                        .parallel_s_axis_tvalid_4(addwindow_m_axis_tvalid_4 && endcheck_flag),
                        .parallel_s_axis_tlast_4(addwindow_m_axis_tlast_4 && endcheck_flag),
                        .parallel_s_axis_tdata_4(addwindow_m_axis_tdata_4),
                        .parallel_s_axis_tready_4(addwindow_m_axis_tready_4),

                        .parallel_s_axis_tvalid_5(addwindow_m_axis_tvalid_5 && endcheck_flag),
                        .parallel_s_axis_tlast_5(addwindow_m_axis_tlast_5 && endcheck_flag),
                        .parallel_s_axis_tdata_5(addwindow_m_axis_tdata_5),
                        .parallel_s_axis_tready_5(addwindow_m_axis_tready_5),

                        .parallel_s_axis_tvalid_6(addwindow_m_axis_tvalid_6 && endcheck_flag),
                        .parallel_s_axis_tlast_6(addwindow_m_axis_tlast_6 && endcheck_flag),
                        .parallel_s_axis_tdata_6(addwindow_m_axis_tdata_6),
                        .parallel_s_axis_tready_6(addwindow_m_axis_tready_6),

                        .parallel_s_axis_tvalid_7(addwindow_m_axis_tvalid_7 && endcheck_flag),
                        .parallel_s_axis_tlast_7(addwindow_m_axis_tlast_7 && endcheck_flag),
                        .parallel_s_axis_tdata_7(addwindow_m_axis_tdata_7),
                        .parallel_s_axis_tready_7(addwindow_m_axis_tready_7),

                        .parallel_s_axis_tvalid_8(addwindow_m_axis_tvalid_8 && endcheck_flag),
                        .parallel_s_axis_tlast_8(addwindow_m_axis_tlast_8 && endcheck_flag),
                        .parallel_s_axis_tdata_8(addwindow_m_axis_tdata_8),
                        .parallel_s_axis_tready_8(addwindow_m_axis_tready_8),


                        .parallel_s_axis_tvalid_ref(addwindow_m_axis_tvalid_ref && endcheck_flag),
                        .parallel_s_axis_tlast_ref(addwindow_m_axis_tlast_ref && endcheck_flag),
                        .parallel_s_axis_tdata_ref(addwindow_m_axis_tdata_ref),
                        .parallel_s_axis_tready_ref(addwindow_m_axis_tready_ref),

                        .GCC_PHAT_m_axis_tvalid(GCC_PHAT_m_axis_tvalid),
                        .GCC_PHAT_m_axis_tdata(GCC_PHAT_m_axis_tdata)

                    );

    //ila_0 ila_0_0 (
    //	.clk(clk_240M), // input wire clk
    //	.probe0(enframe_m_axis_tvalid_6), // input wire [0:0]  probe0
    //	.probe1(enframe_m_axis_tdata_6), // input wire [15:0]  probe1
    //	.probe2(enframe_m_axis_tlast_6), // input wire [0:0]  probe2
    //	.probe3(endcheck_flag),// input wire [0:0]  probe3
    //	.probe4(addwindow_m_axis_tvalid_6 && endcheck_flag), // input wire [0:0]  probe4
    //	.probe5(addwindow_m_axis_tlast_6 && endcheck_flag), // input wire [0:0]  probe5
    //	.probe6(addwindow_m_axis_tdata_6), // input wire [15:0]  probe6
    //	.probe7(GCC_PHAT_m_axis_tvalid), // input wire [0:0]  probe7
    //	.probe8(GCC_PHAT_m_axis_tdata) // input wire [15:0]  probe8
    //);

endmodule
