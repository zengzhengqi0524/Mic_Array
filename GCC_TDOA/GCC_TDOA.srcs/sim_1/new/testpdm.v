`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/20 15:58:20
// Design Name:
// Module Name: testpdm
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
module testpdm();
reg clk_50M;
reg signed [12:0] data; //��Ϊ����Ҫ��%d�ĸ�ʽ�����??�Ա���˵����??
reg [31:0] count;
reg    rstn;
wire PDM_data;
wire PDM_clk;
//wire[10:0]PDM_AXIS_DATA_0_count;
//wire [31:0]PDM_AXIS_DATA_0_tdata;
//wire PDM_AXIS_DATA_0_tvalid;
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
//always #10 clk_50M = ~clk_50M;

initial begin
    #200 rstn = 0;
    #200 rstn = 1;
    #100
     fp = $fopen("C:/Users/IRON/Desktop/GCC_TDOA/GCC_TDOA.srcs/sim_1/new/sin_pdm.txt", "r"); //������ļ��ɹ��Ļ���fp����??��λ����ֵΪ1�������??ʧ�ܣ��ͻ�Ϊ0
    if (!(|fp)) begin
        $display("cannot open file\n");
        #100
         $stop; //��ʱ100ns�������??
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
         $display("done reading\ndata size is %d\n", count + 1); //�������Ҫ��
        $fclose(fp);
        #500
         $stop;
    end
end

pl_test_top pl_test_top_0(
                .PDM_clk(PDM_clk),
                .PDM_in(PDM_data),
                .clk(clk_50M),
                .rstn(rstn));
endmodule
