`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/19 16:26:50
// Design Name:
// Module Name: test_pdm_decode
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
module test_pdm_decode(
       );

reg clk_50M;
reg signed [12:0] data; //因为后面要以%d的格式输出，??以必须说明符??
reg [31:0] count;
reg    rstn;
wire PDM_data;
wire PDM_clk;

integer fp;
assign PDM_data = data[0];

initial begin
    data  = 13'd0;
    count = 32'd0;
    rstn  = 1;
end
always begin
    clk_50M     = 1'b1;
    #10 clk_50M = 1'b0;
    #10;
end

initial begin
    #200 rstn = 0;
    #200 rstn = 1;
    #100
     fp = $fopen("C:/Users/IRON/Desktop/GCC_TDOA/GCC_TDOA.srcs/sim_1/new/sin_pdm.txt", "r"); //如果打开文件成功的话，fp会有??个位被赋值为1；如果打??失败，就会为0
    if (!(|fp)) begin
        $display("cannot open file\n");
        #100
         $stop; //延时100ns后结束仿??
    end
    else begin
        $display("reading file...\n");
        while(!($feof(fp))) begin
            @(posedge PDM_clk) begin
                 $fscanf(fp, "%d", data);
                 count <= count + 32'd1;
                 $display("%d	%d", data, count);
             end
         end
         $display("done reading\ndata size is %d\n", count + 1); //这里很重要！
        $fclose(fp);
        #500
         $stop;
    end
end

clk_wiz_0 clk_wiz_0
          (
              // Clock out ports
              .clk_out1(clk_240M),     // output clk_out1
              // Status and control signals
              .resetn(rstn), // input resetn
              // Clock in ports
              .clk_in1(clk_50M));

clk_div50 clk_div50_0(
              .clk_div50(PDM_clk),
              .clk_in(clk_240M),
              .rstn(rstn));

PDM_decoder PDM_decoder_1(
                .PDM_m_axis_tvalid(),
                .PDM_m_axis_tready(1), // input wire m_axis_tready
                .PDM_m_axis_tdata(), // output wire [31 : 0] m_axis_tdata
                .PDM_in(PDM_data),
                .PDM_clk(PDM_clk),
                .clk_240M(clk_240M),
                .rstn(rstn)
            );

endmodule

