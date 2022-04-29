`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/24 20:26:44
// Design Name:
// Module Name: test_gcc_phat
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


module test_gcc_phat(

       );
reg clk_50M;
reg [31:0] count;
reg  rstn;
wire clk_240M;
integer fp;

reg axis_tvalid;
reg signed [31:0]axis_tdata1;
reg signed [31:0]axis_tdata2;
reg axis_tlast;

reg en_data;
initial begin
    axis_tdata1  = 32'd0;
    axis_tdata2  = 32'd0;
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
    #5000
     fp = $fopen("C:/Users/IRON/Desktop/2_16bit.txt", "r"); //如果打开文件成功的话，fp会有??个位被赋值为1；如果打??失败，就会为0
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

wire [15: 0]GCC_PHAT_CH1_s_axis_tdata;
wire [15: 0]GCC_PHAT_CH2_s_axis_tdata;
wire GCC_PHAT_CH1_s_axis_tvalid;
wire GCC_PHAT_CH2_s_axis_tvalid;
wire GCC_PHAT_CH1_s_axis_tlast;
wire GCC_PHAT_CH2_s_axis_tlast;
addwindow addwindow_1(.rstn(rstn),
                      .clk_240M(clk_240M),
                      .addwindow_s_axis_tvalid(axis_tvalid),
                      .addwindow_s_axis_tready(),
                      .addwindow_s_axis_tdata(axis_tdata1[15:0]),
                      .addwindow_s_axis_tlast(axis_tlast),
                      .addwindow_m_axis_tvalid(GCC_PHAT_CH1_s_axis_tvalid),
                      .addwindow_m_axis_tdata(GCC_PHAT_CH1_s_axis_tdata),
                      .addwindow_m_axis_tlast(GCC_PHAT_CH1_s_axis_tlast),
                      .addwindow_m_axis_tready(1)
                     );
addwindow addwindow_2(.rstn(rstn),
                      .clk_240M(clk_240M),
                      .addwindow_s_axis_tvalid(axis_tvalid),
                      .addwindow_s_axis_tready(),
                      .addwindow_s_axis_tdata(axis_tdata2[15:0]),
                      .addwindow_s_axis_tlast(axis_tlast),
                      .addwindow_m_axis_tvalid(GCC_PHAT_CH2_s_axis_tvalid),
                      .addwindow_m_axis_tdata(GCC_PHAT_CH2_s_axis_tdata),
                      .addwindow_m_axis_tlast(GCC_PHAT_CH2_s_axis_tlast),
                      .addwindow_m_axis_tready(1)
                     );


GCC_PHAT GCC_PHAT_0(
             .rstn(rstn),
             .clk_240M(clk_240M),
             .GCC_PHAT_CH1_s_axis_tvalid(GCC_PHAT_CH1_s_axis_tvalid),
             .GCC_PHAT_CH1_s_axis_tready(),
             .GCC_PHAT_CH1_s_axis_tdata(GCC_PHAT_CH1_s_axis_tdata),
             .GCC_PHAT_CH1_s_axis_tlast(GCC_PHAT_CH1_s_axis_tlast),

             .GCC_PHAT_CH2_s_axis_tvalid(GCC_PHAT_CH2_s_axis_tvalid),
             .GCC_PHAT_CH2_s_axis_tready(),
             .GCC_PHAT_CH2_s_axis_tdata(GCC_PHAT_CH2_s_axis_tdata),
             .GCC_PHAT_CH2_s_axis_tlast(GCC_PHAT_CH2_s_axis_tlast),

             .GCC_PHAT_m_axis_tvalid(),
             .GCC_PHAT_m_axis_tdata()
         );


endmodule
