`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/11 14:43:45
// Design Name:
// Module Name: endcheck
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
module endcheck(
        rstn,
        clk_240M,
        endcheck_s_axis_tvalid,
        endcheck_s_axis_tdata,
        endcheck_s_axis_tlast,
        endcheck_flag
    );

    input    rstn;
    input   clk_240M;
    input   endcheck_s_axis_tvalid;
    input   [15:0]endcheck_s_axis_tdata;
    input   endcheck_s_axis_tlast;
    output  reg endcheck_flag;


    parameter  threshold_E   = 32'h0020_0000;//平均幅度大于阈值2048
    parameter  threshold_Z   = 16'd20; //过零率大于15点
    reg [31:0]volume;
    reg [15:0]zero_counter;

    reg [15:0]pre_data;
    reg [15:0]curr_data;

    wire [15:0]abs_data;
    assign abs_data = (endcheck_s_axis_tdata[15] == 1'b0 ) ? endcheck_s_axis_tdata : ~endcheck_s_axis_tdata + 1'b1;

    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            volume <= 32'b0;
        end
        else begin
            if (endcheck_s_axis_tvalid) begin
                volume <= volume + abs_data;
            end
            else begin
                volume<= 32'b0;
            end
        end
    end

    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            zero_counter <= 16'b0;
        end
        else begin
            if (endcheck_s_axis_tvalid) begin
                zero_counter <= (zero_counter + (pre_data[15]^curr_data[15]));
            end
            else begin
                zero_counter<= 16'b0;
            end
        end
    end

    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            pre_data <= 16'b0;
            curr_data <= 16'b0;
        end
        else begin
            if (endcheck_s_axis_tvalid) begin
                pre_data <= endcheck_s_axis_tdata;
                curr_data <= pre_data;
            end
            else begin
                pre_data <= 16'b0;
                curr_data <= 16'b0;
            end
        end
    end
    reg endcheck_s_axis_tlast_temp1;
    reg endcheck_s_axis_tlast_temp2;
    wire pos_endcheck_s_axis_tlast;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            endcheck_s_axis_tlast_temp1 <= 0;
            endcheck_s_axis_tlast_temp2 <= 0;
        end
        else begin
            endcheck_s_axis_tlast_temp1 <= endcheck_s_axis_tlast;
            endcheck_s_axis_tlast_temp2 <= endcheck_s_axis_tlast_temp1;
        end
    end
    assign pos_endcheck_s_axis_tlast = endcheck_s_axis_tlast_temp1 &&  (~endcheck_s_axis_tlast_temp2) ;

    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            endcheck_flag <= 1'b0;
        end
        else begin
            if (pos_endcheck_s_axis_tlast) begin
                if(volume >threshold_E && zero_counter >threshold_Z)
                    endcheck_flag <= 1'b1;
                else
                    endcheck_flag <= 1'b0;
            end
        end
    end
endmodule
