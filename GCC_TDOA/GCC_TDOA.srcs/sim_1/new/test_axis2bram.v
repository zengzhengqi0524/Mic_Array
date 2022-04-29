`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/30 12:36:08
// Design Name: 
// Module Name: test_axis2bram
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


module test_axis2bram(

    );
reg clk_50M;
reg [31:0] count;
reg  rstn;
wire clk_240M;
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

reg axis_tvalid;
reg [15:0]axis_tdata;

initial begin
    axis_tdata  = 32'd0;
    count = 32'd5;
    rstn  = 1;
    axis_tvalid = 0;
    #100 rstn = 0;
    #100 rstn = 1;
end
always@(posedge clk_240M) begin
    count<= count +1;
end
always@(posedge clk_240M) begin
    if((count % 1000) == 0)begin
        axis_tdata <= count[15:0];
        axis_tvalid <= 1;
    end
    else begin
        axis_tvalid<=0;
        axis_tdata<= 0;
    end
    
end


axis2bram axis2bram_1(
        .clk_240M(clk_240M),
        .rstn(rstn),
        .GCC_PHAT_m_axis_tvalid(axis_tvalid),
        .GCC_PHAT_m_axis_tdata(axis_tdata)       
    );

endmodule
