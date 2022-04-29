`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/29 22:47:53
// Design Name: 
// Module Name: axis2bram
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
module axis2bram(
        input clk_240M,
        input rstn,
        input GCC_PHAT_m_axis_tvalid,
        input[15:0] GCC_PHAT_m_axis_tdata,
        
        // Users to add ports here
         //RAM �˿� 
        output wire ram_clk , //RAM ʱ��
        output wire ram_rst, //RAM ��λ�ź�,�ߵ�ƽ��Ч
        input wire [31:0] ram_rd_data, //RAM �ж���������
        output wire ram_en , //RAM ʹ���ź�
        output wire [31:0] ram_addr , //RAM ��ַ
        output wire [3:0] ram_we , //RAM ��д�����ź�
        output wire [31:0] ram_wr_data, //RAM д����
        output wire ram_rd_irq
        
    );

assign ram_rst = !rstn;
assign ram_clk = clk_240M;
reg en;
reg wen;
reg [31:0]address;
reg [31:0]data;
reg irq;
always @(posedge clk_240M or negedge rstn) begin
    if (!rstn)begin
        en <= 0;
        wen <= 0;
        data <= 0;
        address <= 0;    
    end
    else if (GCC_PHAT_m_axis_tvalid)begin
        en <= 1;
        wen <= 1;
        data <= {16'b0,GCC_PHAT_m_axis_tdata};
        address <= address +1;       
    end
    else if (address == 32'd8)begin
        irq = 1;//д��,�ж���ps��ȡ
        address <= 0;
        en <= 0;
        wen <= 0;
        data <= 0;
    end
    else begin
        irq = 0;
        address <= address;
        en <= 0;
        wen <= 0;
        data <= 0;
    end    
end
//delay 1cycle
reg [31:0]address_temp;
always @(posedge clk_240M or negedge rstn) begin
    if (!rstn)begin 
        address_temp <=0;   
    end
    else begin
        address_temp <= address;
    end
end
assign ram_addr =  address_temp;
assign ram_en = en;
assign ram_we = {4{wen}};
assign ram_wr_data = data;
assign ram_rd_irq = irq;
endmodule
