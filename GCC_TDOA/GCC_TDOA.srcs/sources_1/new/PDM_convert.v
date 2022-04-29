`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/10 14:32:39
// Design Name:
// Module Name: PDM_convert
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
module PDM_convert(
        input PDM_clk,
        input PDM_in,
        output [7:0] PDM_out
    );

    reg signed [7:0] PDM = 8'd0;
    always @ (posedge PDM_clk) begin
        if(PDM_in == 1)
            PDM <= 127;
        else
            PDM <= -127;
    end

    assign PDM_out = PDM;
endmodule


