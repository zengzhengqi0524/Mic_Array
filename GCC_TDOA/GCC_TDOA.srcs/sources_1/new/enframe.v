`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/20 17:21:32
// Design Name:
// Module Name: enframe
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
module enframe(
        rstn,
        clk_240M,
        enframe_s_axis_tvalid,
        enframe_s_axis_tready,
        enframe_s_axis_tdata,
        enframe_m_axis_tvalid,
        enframe_m_axis_tready,
        enframe_m_axis_tdata,
        enframe_m_axis_tlast
    );
    parameter framelength = 1024;
    input rstn;
    input clk_240M;
    input wire enframe_s_axis_tvalid;
    input wire [15 : 0]enframe_s_axis_tdata;
    output wire enframe_s_axis_tready;
    output wire enframe_m_axis_tvalid;
    input wire enframe_m_axis_tready;
    output reg [15 : 0] enframe_m_axis_tdata;
    output wire enframe_m_axis_tlast;

    reg [15:0]counter1;
    reg [15:0]counter2;
    wire fifo1_s_axis_tlast;
    wire fifo1_s_axis_tready;
    wire [15 : 0]fifo1_s_axis_tdata;
    wire fifo1_m_axis_tvalid;
    wire fifo1_m_axis_tready;
    wire [15 : 0]fifo1_m_axis_tdata;
    wire fifo1_m_axis_tlast;

    wire fifo2_s_axis_tlast;
    wire fifo2_s_axis_tready;
    wire [15 : 0]fifo2_s_axis_tdata;
    wire fifo2_m_axis_tvalid;
    wire fifo2_m_axis_tready;
    wire [15 : 0]fifo2_m_axis_tdata;
    wire fifo2_m_axis_tlast;

    axis_data_fifo_0 fifo1 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(fifo1_s_axis_tvalid),    // input wire s_axis_tvalid
                         .s_axis_tready(fifo1_s_axis_tready),    // output wire s_axis_tready
                         .s_axis_tdata(fifo1_s_axis_tdata),      // input wire [15 : 0] s_axis_tdata
                         .s_axis_tlast(fifo1_s_axis_tlast),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo1_m_axis_tvalid),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo1_m_axis_tready),    // input wire m_axis_tready
                         .m_axis_tdata(fifo1_m_axis_tdata),      // output wire [15 : 0] m_axis_tdata
                         .m_axis_tlast(fifo1_m_axis_tlast)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo2 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(fifo2_s_axis_tvalid),    // input wire s_axis_tvalid
                         .s_axis_tready(fifo2_s_axis_tready),    // output wire s_axis_tready
                         .s_axis_tdata(fifo2_s_axis_tdata),      // input wire [15 : 0] s_axis_tdata
                         .s_axis_tlast(fifo2_s_axis_tlast),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo2_m_axis_tvalid),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo2_m_axis_tready),    // input wire m_axis_tready
                         .m_axis_tdata(fifo2_m_axis_tdata),      // output wire [15 : 0] m_axis_tdata
                         .m_axis_tlast(fifo2_m_axis_tlast)      // output wire m_axis_tlast
                     );
    //输入逻辑
    //fifo1 delay 0 point
    assign fifo1_s_axis_tvalid = enframe_s_axis_tvalid;
    assign fifo1_s_axis_tdata = enframe_s_axis_tdata;
    assign fifo1_m_axis_tready = enframe_m_axis_tready;
    //fifo1 tlast logic
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            counter1 <= 0;
        end
        else if ( fifo1_s_axis_tvalid && fifo1_s_axis_tready && (counter1 == framelength-1)) begin
            counter1           <= 0;
        end
        else if  (fifo1_s_axis_tvalid && fifo1_s_axis_tready && (counter1 != framelength-1) ) begin
            counter1 <= counter1 + 1;
        end
        else begin
            counter1 <= counter1;
        end
    end
    assign fifo1_s_axis_tlast = (fifo1_s_axis_tvalid && fifo1_s_axis_tready && (counter1 == framelength-1))? 1 : 0;
    //fifo2 delay 512 point
    reg fifo2_start_flag;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            fifo2_start_flag <= 0;
        end
        else if (counter1 == framelength/2)
            fifo2_start_flag <= 1;
    end
    assign fifo2_s_axis_tvalid = enframe_s_axis_tvalid && fifo2_start_flag;
    assign fifo2_s_axis_tdata = enframe_s_axis_tdata;
    assign fifo2_m_axis_tready = enframe_m_axis_tready;
    //fifo2 tlast logic
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            counter2 <= 0;
        end
        else if ( fifo2_s_axis_tvalid && fifo2_s_axis_tready && (counter2 == framelength-1)) begin
            counter2           <= 0;
        end
        else if  (fifo2_s_axis_tvalid && fifo2_s_axis_tready && (counter2 != framelength-1) ) begin
            counter2 <= counter2 + 1;
        end
        else begin
            counter2 <= counter2;
        end
    end
    assign fifo2_s_axis_tlast = (fifo2_s_axis_tvalid && fifo2_s_axis_tready && (counter2 == framelength-1))? 1 : 0;

    reg outflag = 0;
    //输出逻辑
    assign enframe_s_axis_tready = fifo1_s_axis_tready || fifo2_s_axis_tready;
    assign enframe_m_axis_tlast = fifo1_m_axis_tlast || fifo2_m_axis_tlast;
    //输出数据选择器
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            outflag <= 0;
        end
        else if (fifo1_s_axis_tlast == 1)
            outflag <= 0;
        else if (fifo2_s_axis_tlast == 1)
            outflag <= 1;
    end
    always @  (outflag or fifo1_m_axis_tdata or fifo2_m_axis_tdata ) begin
        case(outflag)
            1'b0 :
                enframe_m_axis_tdata <= fifo1_m_axis_tdata;
            1'b1 :
                enframe_m_axis_tdata <= fifo2_m_axis_tdata;
        endcase
    end

    //   assign enframe_m_axis_tdata = outflag? fifo1_m_axis_tdata : fifo2_m_axis_tdata;
    assign enframe_m_axis_tvalid = fifo1_m_axis_tvalid || fifo2_m_axis_tvalid;
endmodule
