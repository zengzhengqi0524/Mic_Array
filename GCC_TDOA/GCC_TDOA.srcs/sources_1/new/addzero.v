`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:zengzhengqi
//
// Create Date: 2021/05/11 00:08:22
// Design Name:
// Module Name: addzero
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
module addzero(
        rstn,
        clk_240M,
        addzero_s_axis_tvalid,
        addzero_s_axis_tdata,
        addzero_s_axis_tlast,
        addzero_m_axis_tvalid,
        addzero_m_axis_tdata,
        addzero_m_axis_tlast
    );

    input  rstn;
    input  clk_240M;
    input  addzero_s_axis_tvalid;
    input  [31 : 0]  addzero_s_axis_tdata;
    input  addzero_s_axis_tlast;
    output reg [31 : 0]  addzero_m_axis_tdata;
    output  reg addzero_m_axis_tvalid;
    output  reg addzero_m_axis_tlast;

    //状态机
    parameter  IDLE       = 2'b00;
    parameter  TRANDATA   = 2'b01;
    parameter  TRANZERO   = 2'b10;

    reg [15:0] counter;

    reg [1:0]state;

    reg [31 : 0]data_temp1;
    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            data_temp1 <= 32'b0;
        end
        else begin
            data_temp1 <= addzero_s_axis_tdata;
        end
    end
    reg tlast_temp1;
    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            tlast_temp1 <= 1'b0;
        end
        else begin
            tlast_temp1 <= addzero_s_axis_tlast;
        end
    end

    always @(posedge clk_240M or posedge rstn) begin
        if(!rstn) begin
            addzero_m_axis_tdata <= 32'b0;
            addzero_m_axis_tlast <= 1'b0;
            addzero_m_axis_tvalid <= 1'b0;
            counter <= 0;
            state <= IDLE;
        end

        else begin
            case(state)
                IDLE : begin
                    if(addzero_s_axis_tvalid) begin
                        state <= TRANDATA;
                    end
                    else begin
                        state <= IDLE;
                    end
                    addzero_m_axis_tdata <= 32'b0;
                    addzero_m_axis_tlast <= 1'b0;
                    addzero_m_axis_tvalid <= 1'b0;
                    counter <= 0;
                end
                TRANDATA: begin
                    if(tlast_temp1) begin
                        state <= TRANZERO;
                    end
                    else begin
                        state <= TRANDATA;
                    end
                    addzero_m_axis_tdata <= data_temp1;
                    addzero_m_axis_tvalid <= 1;
                    counter <= counter+1'b1;
                end
                TRANZERO: begin
                    if(counter == 16'd2047) begin
                        state <= IDLE;
                        addzero_m_axis_tlast <= 1'b1;
                    end
                    else begin
                        state <= TRANZERO;
                    end
                    addzero_m_axis_tdata <= 32'b0;
                    counter <= counter+1'b1;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
