`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/10 11:40:55
// Design Name:
// Module Name: findmax
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
module findmax(
        rstn,
        clk_240M,
        findmax_s_axis_tvalid,
        findmax_s_axis_tdata,
        findmax_s_axis_tlast,
        findmax_m_axis_tvalid,
        findmax_m_axis_tdata
    );
    input  rstn;
    input  clk_240M;
    input  findmax_s_axis_tvalid;
    input  [31:0]  findmax_s_axis_tdata;//
    input  findmax_s_axis_tlast;
    output [15:0] findmax_m_axis_tdata;
    output reg findmax_m_axis_tvalid;

    reg [31:0]cur_val;
    reg [31:0]max_val;
    reg [15:0] cur_pos;
    reg [15:0] max_pos;
    reg findmax_s_axis_tvalid_delay1;

    always @(posedge clk_240M or negedge rstn) begin
        if(!rstn) begin
            findmax_s_axis_tvalid_delay1 <= 0;
        end
        else begin
            findmax_s_axis_tvalid_delay1 <= findmax_s_axis_tvalid;
        end
    end
    reg findmax_s_axis_tlast_delay1;
    always @(posedge clk_240M or negedge rstn) begin
        if(!rstn) begin
            findmax_s_axis_tlast_delay1 <= 0;
        end
        else begin
            findmax_s_axis_tlast_delay1 <= findmax_s_axis_tlast;
        end
    end
    always @(posedge clk_240M or negedge rstn) begin
        if(!rstn) begin
            cur_pos <= 0;
            cur_val <= 0;
        end
        else begin
            if(findmax_s_axis_tvalid) begin
                if(cur_pos == 1025) begin
                    cur_pos <= cur_pos +1;
                    cur_val <= 0; 
                end
                else begin
                    cur_pos <= cur_pos +1;
                    cur_val <= findmax_s_axis_tdata ;
                end
            end
            else begin
                cur_val <= 0;
                cur_pos <= 0;
            end
        end
    end

    always @(posedge clk_240M or negedge rstn) begin
        if(!rstn) begin
            max_pos <= 0 ;
            max_val <= 0 ;
        end
        else begin
            if(findmax_s_axis_tvalid_delay1) begin
                if (cur_val >= max_val) begin
                    max_pos <= cur_pos;
                    max_val <= cur_val;
                end
            end
            else begin
                max_pos <= 0;
                max_val <= 0;
            end
        end
    end
    always @(posedge clk_240M or negedge rstn) begin
        if(!rstn) begin
            findmax_m_axis_tvalid <= 0;
        end
        else begin
            findmax_m_axis_tvalid <= findmax_s_axis_tlast_delay1;
        end
    end
    assign  findmax_m_axis_tdata = max_pos;

endmodule
