`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/26 12:50:51
// Design Name:
// Module Name: test_axis_parallel2serial
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


module test_GCC_PHAT_serial(

       );
reg clk_50M;
reg [31:0] count;
reg  rstn;
wire clk_240M;

reg axis_tvalid;
reg [15:0]axis_tdata;
reg axis_tlast;
reg endata;

reg GCC_PHAT_m_axis_tvalid;
reg [31:0]times = 1;
always@(posedge clk_240M) begin
    times = times +1;
    if ((times % 10000)==0)
        GCC_PHAT_m_axis_tvalid = 1;
    else 
        GCC_PHAT_m_axis_tvalid = 0;
end
initial begin
    axis_tdata  = 16'd0;
    count = 32'd0;
    rstn  = 1;
    endata = 0;
    axis_tvalid = 0;
    axis_tlast = 0;
    GCC_PHAT_m_axis_tvalid = 0;
    #300 rstn = 0;
    #3000 rstn = 1;
    #1000 endata = 1;
    
    #500000 endata = 1;


end
always@(posedge clk_240M) begin
    if(endata) begin
        axis_tvalid = 1;
        count = count +32'd1;
        axis_tdata = axis_tdata + 32'd1;
        if (count == 16'd1024)
            axis_tlast = 1;
        if (count == 16'd1025)begin
            axis_tlast = 0;
            axis_tvalid = 0;
            endata = 0;
            count = 0;
        end
    end   
end

always begin
    clk_50M     = 1'b1;
    #10 clk_50M = 1'b0;
    #10;
end
clk_wiz_0 clk_wiz_1
          (
              // Clock out ports
              .clk_out1(clk_240M),     // output clk_out1
              // Status and control signals
              .resetn(rstn), // input resetn
              // Clock in ports
              .clk_in1(clk_50M));



GCC_PHAT_serial GCC_PHAT_serial_1(
                         .clk_240M(clk_240M),
                         .rstn(rstn),
                         .parallel_s_axis_tvalid_1(axis_tvalid),
                         .parallel_s_axis_tlast_1(axis_tlast),
                         .parallel_s_axis_tdata_1(axis_tdata + 16'd1),
                         .parallel_s_axis_tready_1(),

                         .parallel_s_axis_tvalid_2(axis_tvalid),
                         .parallel_s_axis_tlast_2(axis_tlast),
                         .parallel_s_axis_tdata_2(axis_tdata + 16'd2),
                         .parallel_s_axis_tready_2(),

                         .parallel_s_axis_tvalid_3(axis_tvalid),
                         .parallel_s_axis_tlast_3(axis_tlast),
                         .parallel_s_axis_tdata_3(axis_tdata + 16'd3),
                         .parallel_s_axis_tready_3(),

                         .parallel_s_axis_tvalid_4(axis_tvalid),
                         .parallel_s_axis_tlast_4(axis_tlast),
                         .parallel_s_axis_tdata_4(axis_tdata + 16'd4),
                         .parallel_s_axis_tready_4(),

                         .parallel_s_axis_tvalid_5(axis_tvalid),
                         .parallel_s_axis_tlast_5(axis_tlast),
                         .parallel_s_axis_tdata_5(axis_tdata + 16'd5),
                         .parallel_s_axis_tready_5(),

                         .parallel_s_axis_tvalid_6(axis_tvalid),
                         .parallel_s_axis_tlast_6(axis_tlast),
                         .parallel_s_axis_tdata_6(axis_tdata + 16'd6),
                         .parallel_s_axis_tready_6(),

                         .parallel_s_axis_tvalid_7(axis_tvalid),
                         .parallel_s_axis_tlast_7(axis_tlast),
                         .parallel_s_axis_tdata_7(axis_tdata + 16'd7),
                         .parallel_s_axis_tready_7(),

                         .parallel_s_axis_tvalid_8(axis_tvalid),
                         .parallel_s_axis_tlast_8(axis_tlast),
                         .parallel_s_axis_tdata_8(axis_tdata + 16'd8),
                         .parallel_s_axis_tready_8(),
                          
                          
                         .parallel_s_axis_tvalid_ref(axis_tvalid),
                         .parallel_s_axis_tlast_ref(axis_tlast),
                         .parallel_s_axis_tdata_ref(axis_tdata + 16'd9),
                         .parallel_s_axis_tready_ref(),

                         .GCC_PHAT_m_axis_tvalid(GCC_PHAT_m_axis_tvalid)
                         
                     );
endmodule
