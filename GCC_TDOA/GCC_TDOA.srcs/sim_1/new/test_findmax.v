`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/10 13:52:16
// Design Name:
// Module Name: test_findmax
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


module test_findmax(

       );
reg clk_50M;
reg [31:0] count;
reg  rstn;
wire clk_240M;

reg axis_tvalid;
reg [31:0]axis_tdata;
reg axis_tlast;
reg endata;
initial begin
    axis_tdata  = 32'd200;
    count = 32'd0;
    rstn  = 1;
    endata = 0;
    axis_tvalid = 0;
    axis_tlast = 0;
    #300 rstn = 0;
    #300 rstn = 1;
    #1000  endata = 1;

end
always@(posedge clk_240M) begin

    if(endata) begin
        axis_tvalid = 1;
        count = count +32'd1;
        if ( count <=32'd100 )begin
            axis_tdata = axis_tdata -32'd1;
        end
        else begin
            axis_tdata = axis_tdata -32'd1;
        end
        if (count == 32'd199)
            axis_tlast = 1;
        if (count == 32'd200)begin
            axis_tlast = 0;
            axis_tvalid = 0;
            endata = 0;
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
wire [31:0] findmax_s_axis_tdata;
wire  findmax_s_axis_tvalid ;
wire  findmax_s_axis_tlast;
assign    findmax_s_axis_tdata =  axis_tdata;
assign    findmax_s_axis_tvalid =  axis_tvalid;
assign    findmax_s_axis_tlast =  axis_tlast;
findmax findmax_0(
            .clk_240M(clk_240M),                                        // input wire aclk
            .rstn(rstn),
            .findmax_s_axis_tvalid(findmax_s_axis_tvalid),
            .findmax_s_axis_tdata(findmax_s_axis_tdata),
            .findmax_s_axis_tlast(findmax_s_axis_tlast)
        );

endmodule
