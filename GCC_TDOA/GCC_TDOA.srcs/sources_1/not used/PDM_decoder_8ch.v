`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/30 23:29:53
// Design Name:
// Module Name: PDM_decoder_8ch
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
module PDM_decoder_8ch(
        PDM_in_1,
        PDM_in_2,
        PDM_in_3,
        PDM_in_4,
        PDM_in_5,
        PDM_in_6,
        PDM_in_7,
        PDM_in_8,
        clk_240M,
        PDM_clk,
        rstn,
        fifo_full_irq,
        fifo_m_axis_tvalid, // output wire m_axis_tvalid
        fifo_m_axis_tready, // input wire m_axis_tready
        fifo_m_axis_tdata,  // output wire [255 : 0] m_axis_tdata
        fifo_m_axis_tkeep,  // output wire [31 : 0] m_axis_tkeep
        fifo_m_axis_tlast,
        fifo_counter
    );
    //---------------------------------------------------------------------------
    //--	符号常量
    //---------------------------------------------------------------------------
    parameter datalength = 1023;
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
    input clk_240M;
    input rstn;
    output PDM_clk;

    output reg fifo_full_irq;
    output fifo_m_axis_tvalid;           // output wire m_axis_tvalid
    input fifo_m_axis_tready;           // input wire m_axis_tready
    output [255 : 0] fifo_m_axis_tdata;
    output [31 : 0] fifo_m_axis_tkeep;  // output wire [31 : 0] m_axis_tkeep
    output  fifo_m_axis_tlast;
    output [31:0]fifo_counter;

    //---------------------------------------------------------------------------
    //--	内部端口声明
    //---------------------------------------------------------------------------

    reg [31:0]counter;
    wire fifo_s_axis_tlast;

    wire [31 : 0] fifo_axis_data_count;        // output wire [31 : 0] axis_data_count
    wire [31 : 0] fifo_axis_wr_data_count;  // output wire [31 : 0] axis_wr_data_count
    wire [31 : 0] fifo_axis_rd_data_count;

    wire PDM_m_axis_tvalid_1;
    wire PDM_m_axis_tready_1;
    wire [31 : 0]PDM_m_axis_tdata_1;
    wire PDM_m_axis_tvalid_2;
    wire PDM_m_axis_tready_2;
    wire [31 : 0]PDM_m_axis_tdata_2;
    wire PDM_m_axis_tvalid_3;
    wire PDM_m_axis_tready_3;
    wire [31 : 0]PDM_m_axis_tdata_3;
    wire PDM_m_axis_tvalid_4;
    wire PDM_m_axis_tready_4;
    wire [31 : 0]PDM_m_axis_tdata_4;
    wire PDM_m_axis_tvalid_5;
    wire PDM_m_axis_tready_5;
    wire [31 : 0]PDM_m_axis_tdata_5;
    wire PDM_m_axis_tvalid_6;
    wire PDM_m_axis_tready_6;
    wire [31 : 0]PDM_m_axis_tdata_6;
    wire PDM_m_axis_tvalid_7;
    wire PDM_m_axis_tready_7;
    wire [31 : 0]PDM_m_axis_tdata_7;
    wire PDM_m_axis_tvalid_8;
    wire PDM_m_axis_tready_8;
    wire [31 : 0]PDM_m_axis_tdata_8;


    wire [7 : 0] axis_combiner_s_axis_tvalid;  // input wire [7 : 0] s_axis_tvalid
    wire [7 : 0] axis_combiner_s_axis_tready;  // output wire [7 : 0] s_axis_tready
    wire [255 : 0] axis_combiner_s_axis_tdata;   // input wire [255 : 0] s_axis_tdata
    wire axis_combiner_m_axis_tvalid;  // output wire m_axis_tvalid
    wire axis_combiner_m_axis_tready;  // input wire m_axis_tready
    wire [255 : 0] axis_combiner_m_axis_tdata;   // output wire [255 : 0] m_axis_tdata


    //---------------------------------------------------------------------------
    //--	逻辑功能实现
    //---------------------------------------------------------------------------

    assign fifo_counter = fifo_axis_data_count;

    clk_div50 clk_div50_0(
                  .clk_div50(PDM_clk),
                  .clk_in(clk_240M),
                  .rstn(rstn));


    PDM_decoder PDM_decoder_1(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_1),
                    .PDM_m_axis_tready(PDM_m_axis_tready_1), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_1), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_1),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_2(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_2),
                    .PDM_m_axis_tready(PDM_m_axis_tready_2), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_2), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_2),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_3(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_3),
                    .PDM_m_axis_tready(PDM_m_axis_tready_3), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_3), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_3),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_4(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_4),
                    .PDM_m_axis_tready(PDM_m_axis_tready_4), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_4), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_4),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_5(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_5),
                    .PDM_m_axis_tready(PDM_m_axis_tready_5), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_5), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_5),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_6(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_6),
                    .PDM_m_axis_tready(PDM_m_axis_tready_6), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_6), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_6),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_7(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_7),
                    .PDM_m_axis_tready(PDM_m_axis_tready_7), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_7), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_7),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    PDM_decoder PDM_decoder_8(
                    .PDM_m_axis_tvalid(PDM_m_axis_tvalid_8),
                    .PDM_m_axis_tready(PDM_m_axis_tready_8), // input wire m_axis_tready
                    .PDM_m_axis_tdata(PDM_m_axis_tdata_8), // output wire [31 : 0] m_axis_tdata
                    .PDM_in(PDM_in_8),
                    .PDM_clk(PDM_clk),
                    .clk_240M(clk_240M),
                    .rstn(rstn)
                );

    assign axis_combiner_s_axis_tvalid =
           {PDM_m_axis_tvalid_8,
            PDM_m_axis_tvalid_7,
            PDM_m_axis_tvalid_6,
            PDM_m_axis_tvalid_5,
            PDM_m_axis_tvalid_4,
            PDM_m_axis_tvalid_3,
            PDM_m_axis_tvalid_2,
            PDM_m_axis_tvalid_1};

    assign axis_combiner_s_axis_tdata =
           {PDM_m_axis_tdata_8,
            PDM_m_axis_tdata_7,
            PDM_m_axis_tdata_6,
            PDM_m_axis_tdata_5,
            PDM_m_axis_tdata_4,
            PDM_m_axis_tdata_3,
            PDM_m_axis_tdata_2,
            PDM_m_axis_tdata_1};

    assign {
            PDM_m_axis_tready_8,
            PDM_m_axis_tready_7,
            PDM_m_axis_tready_6,
            PDM_m_axis_tready_5,
            PDM_m_axis_tready_4,
            PDM_m_axis_tready_3,
            PDM_m_axis_tready_2,
            PDM_m_axis_tready_1} = axis_combiner_s_axis_tready ;

    axis_combiner_0 axis_combiner (
                        .aclk(clk_240M),                    // input wire aclk
                        .aresetn(rstn),              // input wire aresetn
                        .s_axis_tvalid(axis_combiner_s_axis_tvalid),  // input wire [7 : 0] s_axis_tvalid
                        .s_axis_tready(axis_combiner_s_axis_tready),  // output wire [7 : 0] s_axis_tready
                        .s_axis_tdata(axis_combiner_s_axis_tdata),    // input wire [255 : 0] s_axis_tdata
                        .m_axis_tvalid(axis_combiner_m_axis_tvalid),  // output wire m_axis_tvalid
                        .m_axis_tready(axis_combiner_m_axis_tready),  // input wire m_axis_tready
                        .m_axis_tdata(axis_combiner_m_axis_tdata)    // output wire [255 : 0] m_axis_tdata
                    );

    axis_data_fifo_0 fifo_0(
                         .s_axis_aresetn(rstn),          // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),                // input wire s_axis_aclk

                         .s_axis_tvalid(axis_combiner_m_axis_tvalid),            // input wire s_axis_tvalid
                         .s_axis_tready(axis_combiner_m_axis_tready),            // output wire s_axis_tready
                         .s_axis_tdata(axis_combiner_m_axis_tdata),              // input wire [255 : 0] s_axis_tdata
                         .s_axis_tkeep(32'hffff_ffff),              // input wire [31 : 0] s_axis_tkeep
                         .s_axis_tlast(fifo_s_axis_tlast),              // input wire s_axis_tlast

                         .m_axis_tvalid(fifo_m_axis_tvalid),            // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready),            // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata),              // output wire [255 : 0] m_axis_tdata
                         .m_axis_tkeep(fifo_m_axis_tkeep),              // output wire [31 : 0] m_axis_tkeep
                         .m_axis_tlast(fifo_m_axis_tlast),              // output wire m_axis_tlast

                         .axis_data_count(fifo_axis_data_count),        // output wire [31 : 0] axis_data_count
                         .axis_wr_data_count(fifo_axis_wr_data_count),  // output wire [31 : 0] axis_wr_data_count
                         .axis_rd_data_count(fifo_axis_rd_data_count) // output wire [31 : 0] axis_rd_data_count
                     );




    //tlast logic
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            counter <= 0;
        end

        else if ( axis_combiner_m_axis_tvalid && axis_combiner_m_axis_tready && (counter == datalength)) begin
            counter           <= 0;
        end
        else if  (axis_combiner_m_axis_tvalid && axis_combiner_m_axis_tready && (counter != datalength) ) begin
            counter <= counter + 1;
        end
        else begin
            counter <=counter;
        end

    end
    assign fifo_s_axis_tlast = (axis_combiner_m_axis_tvalid && axis_combiner_m_axis_tready && (counter == datalength))? 1 : 0;
    //fifo full irq signal logic
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            fifo_full_irq <= 0;
        end
        else
            fifo_full_irq <= fifo_s_axis_tlast;
    end
endmodule

