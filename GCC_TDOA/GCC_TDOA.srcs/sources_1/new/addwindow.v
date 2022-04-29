`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/23 10:20:12
// Design Name:
// Module Name: AddWindow
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
module addwindow(
        rstn,
        clk_240M,
        addwindow_s_axis_tvalid,
        addwindow_s_axis_tready,
        addwindow_s_axis_tdata,
        addwindow_s_axis_tlast,

        addwindow_m_axis_tvalid,
        addwindow_m_axis_tdata,
        addwindow_m_axis_tlast,
        addwindow_m_axis_tready

    );

    input rstn;
    input clk_240M;
    input wire addwindow_s_axis_tvalid;
    input wire [15 : 0]addwindow_s_axis_tdata;
    output wire addwindow_s_axis_tready;
    input wire addwindow_s_axis_tlast;
    assign addwindow_s_axis_tready = 1;

    output addwindow_m_axis_tvalid;
    output  [15 : 0] addwindow_m_axis_tdata;
    output addwindow_m_axis_tlast;
    input  addwindow_m_axis_tready;
    //memory address
    reg [9:0] address;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            address <= 0;
        end
        else if (addwindow_s_axis_tvalid) begin
            address <= address +1;
        end
        else if (!addwindow_s_axis_tvalid ) begin
            address <= 0;
        end
    end
    //hamming data (2 cycles delay)
    wire[15 : 0]hamming_data;
    blk_mem_gen_0 hamming1024 (
                      .clka(clk_240M),    // input wire clka
                      .ena(1),      // input wire ena
                      .addra(address),  // input wire [9 : 0] addra
                      .douta(hamming_data)// output wire [15 : 0] douta
                  );

    //channle A
    reg  cmpy_s_axis_a_tvalid_temp1;
    reg  cmpy_s_axis_a_tlast_temp1;
    reg  [15:0]cmpy_s_axis_a_tdata_temp1;

    reg cmpy_s_axis_a_tvalid;
    reg cmpy_s_axis_a_tlast;
    reg [31 : 0]cmpy_s_axis_a_tdata;
    //delay 2 cycles
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            cmpy_s_axis_a_tvalid_temp1 <= 0;
            cmpy_s_axis_a_tvalid <= 0;
        end
        else begin
            cmpy_s_axis_a_tvalid_temp1 <= addwindow_s_axis_tvalid;
            cmpy_s_axis_a_tvalid <= cmpy_s_axis_a_tvalid_temp1;
        end
    end
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            cmpy_s_axis_a_tlast_temp1 <= 0;
            cmpy_s_axis_a_tlast <= 0;
        end
        else begin
            cmpy_s_axis_a_tlast_temp1 <= addwindow_s_axis_tlast;
            cmpy_s_axis_a_tlast <= cmpy_s_axis_a_tlast_temp1;
        end
    end
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            cmpy_s_axis_a_tdata_temp1 <= 0;
            cmpy_s_axis_a_tdata <= 0;
        end
        else begin
            cmpy_s_axis_a_tdata_temp1 <= addwindow_s_axis_tdata;
            cmpy_s_axis_a_tdata  <= {16'b0,cmpy_s_axis_a_tdata_temp1};
        end
    end

    //channle B
    wire cmpy_s_axis_b_tvalid;
    wire [31 : 0]cmpy_s_axis_b_tdata;
    assign cmpy_s_axis_b_tdata = {16'b0,hamming_data};

    assign cmpy_s_axis_b_tvalid = cmpy_s_axis_a_tvalid;

    //output
    wire cmpy_m_axis_dout_tvalid;
    wire cmpy_m_axis_dout_tlast;
    wire [79 : 0]cmpy_m_axis_dout_tdata;
    //Multiply to add hamming window
    cmpy_0 cmpy_0_0 (
               .aclk(clk_240M),                              // input wire aclk
               .aresetn(rstn),                        // input wire aresetn
               .s_axis_a_tvalid(cmpy_s_axis_a_tvalid),        // input wire s_axis_a_tvalid
               .s_axis_a_tlast(cmpy_s_axis_a_tlast),          // input wire s_axis_a_tlast
               .s_axis_a_tdata(cmpy_s_axis_a_tdata),          // input wire [31: 0] s_axis_a_tdata
               .s_axis_b_tvalid(cmpy_s_axis_b_tvalid),        // input wire s_axis_b_tvalid
               .s_axis_b_tdata(cmpy_s_axis_b_tdata),          // input wire [31 : 0] s_axis_b_tdata
               .m_axis_dout_tvalid(cmpy_m_axis_dout_tvalid),  // output wire m_axis_dout_tvalid
               .m_axis_dout_tlast(cmpy_m_axis_dout_tlast),    // output wire m_axis_dout_tlast
               .m_axis_dout_tdata(cmpy_m_axis_dout_tdata)    // output wire [79 : 0] m_axis_dout_tdata
           );
    //输出数据转为axis
    axis_data_fifo_0 fifo3 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(cmpy_m_axis_dout_tvalid),    // input wire s_axis_tvalid
                         .s_axis_tready(),    // output wire s_axis_tready
                         .s_axis_tdata({cmpy_m_axis_dout_tdata[32],cmpy_m_axis_dout_tdata[29:15]}),      // input wire [15 : 0] s_axis_tdata//bit 15:0 截位16vit
                         .s_axis_tlast(cmpy_m_axis_dout_tlast),      // input wire s_axis_tlast
                         .m_axis_tvalid(addwindow_m_axis_tvalid),    // output wire m_axis_tvalid
                         .m_axis_tready(addwindow_m_axis_tready),    // input wire m_axis_tready
                         .m_axis_tdata(addwindow_m_axis_tdata),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(addwindow_m_axis_tlast)      // output wire m_axis_tlast
                     );
endmodule
