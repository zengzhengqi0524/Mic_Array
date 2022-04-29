`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/24 13:28:32
// Design Name:
// Module Name: clk_div50
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
module clk_div50(
        input clk_in,
        input rstn,
        output clk_div50
    );

    reg [7:0] cnt = 8'd0;
    reg clk_out   = 1'b0;


    always @ (posedge clk_in or negedge rstn) begin
        if (!rstn) begin
            cnt     = 8'd0;
            clk_out = 1'b0;
        end
        else if (cnt == 8'd25-1) begin
            cnt     <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
    assign clk_div50 = clk_out;

endmodule
