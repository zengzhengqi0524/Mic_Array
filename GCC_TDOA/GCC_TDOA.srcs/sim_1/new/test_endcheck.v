`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/11 15:18:52
// Design Name:
// Module Name: test_endcheck
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


module test_endcheck(

       );
reg clk_50M;
reg [31:0] count;
reg  rstn;
wire clk_240M;
integer fp;

reg axis_tvalid;
reg signed [15:0]axis_tdata1;
reg signed [15:0]axis_tdata2;
reg axis_tlast;

reg en_data;
initial begin
    axis_tdata1  = 16'd0;
    axis_tdata2  = 16'd0;
    count = 32'd0;
    rstn  = 1;
    axis_tvalid = 0;
    axis_tlast = 0;
    en_data = 1;
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

initial begin
    #200 rstn = 0;
    #200 rstn = 1;
    #1000
     fp = $fopen("C:/Users/IRON/Desktop/4.txt", "r"); //如果打开文件成功的话，fp会有??个位被赋值为1；如果打??失败，就会为0
    if (!(|fp)) begin
        $display("cannot open file\n");
        #100
         $stop; //延时100ns后结束仿??
    end
    else begin
        $display("reading file...\n");
        while(!($feof(fp))) begin
            @(posedge clk_240M && en_data) begin
                 axis_tvalid = 1;
                 $fscanf(fp,"%d  %d", axis_tdata1,axis_tdata2);
                 count <= count + 32'd1;
                 $display("%d	%d %d", axis_tdata1,axis_tdata2, count);
                 if (count == 32'd1023)begin
                     axis_tlast = 1;
                 end
                 else if (count == 32'd1024)begin
                     axis_tvalid = 0;
                     en_data = 0;
                     axis_tlast = 0;
                 end
             end
         end
         $display("done reading\ndata size is %d\n", count + 1); //这里很重要！
        $fclose(fp);
    end
end


wire [31:0] endcheck_s_axis_tdata;
wire  endcheck_s_axis_tvalid ;
wire  endcheck_s_axis_tlast;
assign    endcheck_s_axis_tdata =  axis_tdata1;
assign    endcheck_s_axis_tvalid =  axis_tvalid;
assign    endcheck_s_axis_tlast =  axis_tlast;
endcheck endcheck_0(
             .clk_240M(clk_240M),                                        // input wire aclk
             .rstn(rstn),
             .endcheck_s_axis_tvalid(endcheck_s_axis_tvalid),
             .endcheck_s_axis_tdata(endcheck_s_axis_tdata),
             .endcheck_s_axis_tlast(endcheck_s_axis_tlast)
         );
endmodule
