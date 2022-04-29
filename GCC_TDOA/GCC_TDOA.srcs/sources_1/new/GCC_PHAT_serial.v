`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/18 16:52:46
// Design Name:
// Module Name: GCC_PHAT_serial
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
module GCC_PHAT_serial(
        clk_240M,
        rstn,
        parallel_s_axis_tvalid_1,
        parallel_s_axis_tlast_1,
        parallel_s_axis_tdata_1,
        parallel_s_axis_tready_1,

        parallel_s_axis_tvalid_2,
        parallel_s_axis_tlast_2,
        parallel_s_axis_tdata_2,
        parallel_s_axis_tready_2,

        parallel_s_axis_tvalid_3,
        parallel_s_axis_tlast_3,
        parallel_s_axis_tdata_3,
        parallel_s_axis_tready_3,

        parallel_s_axis_tvalid_4,
        parallel_s_axis_tlast_4,
        parallel_s_axis_tdata_4,
        parallel_s_axis_tready_4,

        parallel_s_axis_tvalid_5,
        parallel_s_axis_tlast_5,
        parallel_s_axis_tdata_5,
        parallel_s_axis_tready_5,

        parallel_s_axis_tvalid_6,
        parallel_s_axis_tlast_6,
        parallel_s_axis_tdata_6,
        parallel_s_axis_tready_6,

        parallel_s_axis_tvalid_7,
        parallel_s_axis_tlast_7,
        parallel_s_axis_tdata_7,
        parallel_s_axis_tready_7,

        parallel_s_axis_tvalid_8,
        parallel_s_axis_tlast_8,
        parallel_s_axis_tdata_8,
        parallel_s_axis_tready_8,

        parallel_s_axis_tvalid_ref,
        parallel_s_axis_tlast_ref,
        parallel_s_axis_tdata_ref,
        parallel_s_axis_tready_ref,

        GCC_PHAT_m_axis_tvalid,
        GCC_PHAT_m_axis_tdata
    );
    input   clk_240M;
    input   rstn;
    input   parallel_s_axis_tvalid_1;
    input   parallel_s_axis_tlast_1;
    input   [15:0] parallel_s_axis_tdata_1;
    output  parallel_s_axis_tready_1;

    input   parallel_s_axis_tvalid_2;
    input   parallel_s_axis_tlast_2;
    input   [15:0] parallel_s_axis_tdata_2;
    output  parallel_s_axis_tready_2;

    input   parallel_s_axis_tvalid_3;
    input   parallel_s_axis_tlast_3;
    input   [15:0] parallel_s_axis_tdata_3;
    output  parallel_s_axis_tready_3;

    input   parallel_s_axis_tvalid_4;
    input   parallel_s_axis_tlast_4;
    input   [15:0] parallel_s_axis_tdata_4;
    output  parallel_s_axis_tready_4;

    input   parallel_s_axis_tvalid_5;
    input   parallel_s_axis_tlast_5;
    input   [15:0] parallel_s_axis_tdata_5;
    output  parallel_s_axis_tready_5;

    input   parallel_s_axis_tvalid_6;
    input   parallel_s_axis_tlast_6;
    input   [15:0] parallel_s_axis_tdata_6;
    output  parallel_s_axis_tready_6;

    input   parallel_s_axis_tvalid_7;
    input   parallel_s_axis_tlast_7;
    input   [15:0] parallel_s_axis_tdata_7;
    output  parallel_s_axis_tready_7;

    input   parallel_s_axis_tvalid_8;
    input   parallel_s_axis_tlast_8;
    input   [15:0] parallel_s_axis_tdata_8;
    output  parallel_s_axis_tready_8;

    input   parallel_s_axis_tvalid_ref;
    input   wire parallel_s_axis_tlast_ref;
    input   wire [15:0] parallel_s_axis_tdata_ref;
    output  parallel_s_axis_tready_ref;



    parameter   IDLE    = 10'b00_0000_0001;
    parameter   WRITE   = 10'b00_0000_0010;
    parameter   READ1   = 10'b00_0000_0100;
    parameter   READ2   = 10'b00_0000_1000;
    parameter   READ3   = 10'b00_0001_0000;
    parameter   READ4   = 10'b00_0010_0000;
    parameter   READ5   = 10'b00_0100_0000;
    parameter   READ6   = 10'b00_1000_0000;
    parameter   READ7   = 10'b01_0000_0000;
    parameter   READ8   = 10'b10_0000_0000;
    reg [9:0]state;
    assign parallel_s_axis_tready_ref = 1 ;
    wire fifo_m_axis_tvalid_1;
    wire fifo_m_axis_tready_1;
    wire [15: 0]fifo_m_axis_tdata_1;
    wire fifo_m_axis_tlast_1;

    wire fifo_m_axis_tvalid_2;
    wire fifo_m_axis_tready_2;
    wire [15: 0]fifo_m_axis_tdata_2;
    wire fifo_m_axis_tlast_2;

    wire fifo_m_axis_tvalid_3;
    wire fifo_m_axis_tready_3;
    wire [15: 0]fifo_m_axis_tdata_3;
    wire fifo_m_axis_tlast_3;

    wire fifo_m_axis_tvalid_4;
    wire fifo_m_axis_tready_4;
    wire [15: 0]fifo_m_axis_tdata_4;
    wire fifo_m_axis_tlast_4;

    wire fifo_m_axis_tvalid_5;
    wire fifo_m_axis_tready_5;
    wire [15: 0]fifo_m_axis_tdata_5;
    wire fifo_m_axis_tlast_5;

    wire fifo_m_axis_tvalid_6;
    wire fifo_m_axis_tready_6;
    wire [15: 0]fifo_m_axis_tdata_6;
    wire fifo_m_axis_tlast_6;

    wire fifo_m_axis_tvalid_7;
    wire fifo_m_axis_tready_7;
    wire [15: 0]fifo_m_axis_tdata_7;
    wire fifo_m_axis_tlast_7;

    wire fifo_m_axis_tvalid_8;
    wire fifo_m_axis_tready_8;
    wire [15: 0]fifo_m_axis_tdata_8;
    wire fifo_m_axis_tlast_8;


    reg serial_m_axis_tvalid;
    reg serial_m_axis_tlast;
    reg [15:0]serial_m_axis_tdata;
    wire serial_m_axis_tready;

    output [15:0]GCC_PHAT_m_axis_tdata;
    output wire GCC_PHAT_m_axis_tvalid;

    ///////////debug//////////////
    // assign serial_m_axis_tready = 1;
    // input GCC_PHAT_m_axis_tvalid;
    /////////////////////////////

    axis_data_fifo_0 fifo1 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_1),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_1),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_1),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_1),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_1),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_1),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_1),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_1)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo2 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_2),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_2),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_2),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_2),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_2),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_2),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_2),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_2)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo3 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_3),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_3),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_3),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_3),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_3),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_3),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_3),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_3)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo4 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_4),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_4),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_4),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_4),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_4),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_4),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_4),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_4)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo5 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_5),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_5),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_5),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_5),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_5),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_5),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_5),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_5)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo6 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_6),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_6),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_6),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_6),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_6),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_6),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_6),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_6)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo7 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_7),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_7),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_7),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_7),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_7),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_7),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_7),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_7)      // output wire m_axis_tlast
                     );

    axis_data_fifo_0 fifo8 (
                         .s_axis_aresetn(rstn),  // input wire s_axis_aresetn
                         .s_axis_aclk(clk_240M),        // input wire s_axis_aclk
                         .s_axis_tvalid(parallel_s_axis_tvalid_8),    // input wire s_axis_tvalid
                         .s_axis_tready(parallel_s_axis_tready_8),    // output wire s_axis_tready
                         .s_axis_tdata(parallel_s_axis_tdata_8),      // input wire [15 : 0] s_axis_tdata//bit 15:0 �G܇??15bit
                         .s_axis_tlast(parallel_s_axis_tlast_8),      // input wire s_axis_tlast
                         .m_axis_tvalid(fifo_m_axis_tvalid_8),    // output wire m_axis_tvalid
                         .m_axis_tready(fifo_m_axis_tready_8),    // input wire m_axis_tready
                         .m_axis_tdata(fifo_m_axis_tdata_8),      // output wire [15: 0] m_axis_tdata
                         .m_axis_tlast(fifo_m_axis_tlast_8)      // output wire m_axis_tlast
                     );

    reg [3:0]delay = 4'd0;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            state  <= IDLE;
            delay <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    if(parallel_s_axis_tvalid_1) begin
                        state <= WRITE;
                    end
                    else begin
                        state <= state;
                    end

                end
                WRITE: begin
                    if(!parallel_s_axis_tvalid_1) begin
                        if(delay == 4'd5) begin
                            state <= READ1;
                            delay <=0;
                        end
                        else begin
                            delay = delay + 4'b1;
                        end
                    end
                    else begin
                        state <= state;
                    end
                end
                READ1: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ2;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ2: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ3;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ3: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ4;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ4: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ5;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ5: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ6;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ6: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ7;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ7: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= READ8;
                    end
                    else begin
                        state <= state;
                    end
                end
                READ8: begin
                    if (GCC_PHAT_m_axis_tvalid) begin
                        state <= IDLE;
                    end
                    else begin
                        state <= state;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
    wire [7:0]fifo_m_axis_tready;
    assign  {fifo_m_axis_tready_8,
             fifo_m_axis_tready_7,
             fifo_m_axis_tready_6,
             fifo_m_axis_tready_5,
             fifo_m_axis_tready_4,
             fifo_m_axis_tready_3,
             fifo_m_axis_tready_2,
             fifo_m_axis_tready_1} = fifo_m_axis_tready;

    assign fifo_m_axis_tready = ( state[9:2]& {8{serial_m_axis_tready}});
    // fifo mux
    always@(*) begin
        case(state)
            IDLE: begin
                serial_m_axis_tvalid <=0;
                serial_m_axis_tlast <=0;
                serial_m_axis_tdata <=16'b0;
            end
            WRITE: begin
                serial_m_axis_tvalid <=0;
                serial_m_axis_tlast <=0;
                serial_m_axis_tdata <=16'b0;
            end
            READ1: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_1 && fifo_m_axis_tready_1;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_1;
                serial_m_axis_tdata   <= fifo_m_axis_tdata_1;
            end
            READ2: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_2 && fifo_m_axis_tready_2;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_2 ;
                serial_m_axis_tdata   <= fifo_m_axis_tdata_2;
            end
            READ3: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_3 && fifo_m_axis_tready_3;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_3 ;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_3;
            end
            READ4: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_4 && fifo_m_axis_tready_4;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_4;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_4;
            end
            READ5: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_5&& fifo_m_axis_tready_5;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_5;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_5;
            end
            READ6: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_6&& fifo_m_axis_tready_6;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_6 ;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_6;
            end
            READ7: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_7&& fifo_m_axis_tready_7;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_7 ;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_7;
            end
            READ8: begin
                serial_m_axis_tvalid  <= fifo_m_axis_tvalid_8&& fifo_m_axis_tready_8;
                serial_m_axis_tlast   <= fifo_m_axis_tlast_8;
                serial_m_axis_tdata  <= fifo_m_axis_tdata_8;
            end
            default: begin
                serial_m_axis_tvalid <=0;
                serial_m_axis_tlast <=0;
                serial_m_axis_tdata <=16'b0;
            end
        endcase
    end

    wire GCC_PHAT_CH1_s_axis_tvalid;
    wire GCC_PHAT_CH1_s_axis_tlast;
    wire [15:0]GCC_PHAT_CH1_s_axis_tdata;
    wire serial_wire_m_axis_tvalid;
    wire serial_wire_m_axis_tlast;
    wire [15:0]serial_wire_m_axis_tdata;
    assign serial_wire_m_axis_tvalid = serial_m_axis_tvalid;
    assign serial_wire_m_axis_tlast = serial_m_axis_tlast;
    assign serial_wire_m_axis_tdata = serial_m_axis_tdata;
    c_shift_ram_1 delay_3cycle (
                      .D({serial_wire_m_axis_tvalid,serial_wire_m_axis_tlast,serial_wire_m_axis_tdata}),      // input wire [17 : 0] D
                      .CLK(clk_240M),  // input wire CLK
                      .Q({GCC_PHAT_CH1_s_axis_tvalid,GCC_PHAT_CH1_s_axis_tlast,GCC_PHAT_CH1_s_axis_tdata})      // output wire [17 : 0] Q
                  );


    reg [9 : 0]address;
    reg [9 : 0]addra;
    reg ena;
    reg wea;
    reg [16:0]dina;
    wire [16:0]douta;
    blk_mem_gen_1 ram_data_ref (
                      .clka(clk_240M),    // input wire clka
                      .ena(ena),      // input wire ena
                      .wea(wea),      // input wire [0 : 0] wea
                      .addra(addra),  // input wire [9 : 0] addra
                      .dina(dina),    // input wire [16 : 0] dina  //tlast 1bit tdata 16bit
                      .douta(douta)  // output wire [16 : 0] douta
                  );
    //delay 1 cycle
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            addra <= 10'd0;
        end
        else begin
            addra <= address;
        end
    end


    //write and read 8 cycle ram data_ref
    reg GCC_PHAT_CH2_s_axis_tvalid;
    reg GCC_PHAT_CH2_s_axis_tlast;
    reg [15:0]GCC_PHAT_CH2_s_axis_tdata;

    reg tvaild = 0;
    reg readonce = 0 ;
    reg writeonce = 0;
    //ram dout data����ʱ��
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            GCC_PHAT_CH2_s_axis_tlast <= 1'd0;
            GCC_PHAT_CH2_s_axis_tdata <= 16'd0;
        end
        else begin
            {GCC_PHAT_CH2_s_axis_tlast,GCC_PHAT_CH2_s_axis_tdata}  =  douta;
        end
    end

    reg GCC_PHAT_CH2_s_axis_tvalid_temp;
    //delay 2 cycle
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            GCC_PHAT_CH2_s_axis_tvalid_temp <= 0;
            GCC_PHAT_CH2_s_axis_tvalid <= 0;
        end
        else begin
            GCC_PHAT_CH2_s_axis_tvalid_temp <= tvaild;
            GCC_PHAT_CH2_s_axis_tvalid<=  GCC_PHAT_CH2_s_axis_tvalid_temp;
        end
    end
    //write
    reg [16:0]dina_temp;
    wire [16:0]dina_tlast_tdata ;
    assign dina_tlast_tdata = {parallel_s_axis_tlast_ref,parallel_s_axis_tdata_ref};
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            dina_temp <= 0;
            dina <= 0;
        end
        else begin
            dina_temp <= dina_tlast_tdata;
            dina  <= dina_temp;
        end
    end

    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            address <= 10'd0;
            ena <= 0;
            wea <= 0;
            tvaild<=0;
        end
        else begin
            if (writeonce) begin
                ena <= 1;
                wea <= 1;
                address <= address + 1;
                if (address == 10'd1023) begin
                    address <= 10'd0;
                end
            end
            else if (readonce) begin
                ena <= 1;
                wea <= 0;
                address <= address + 1;
                tvaild <= 1;
                if (address == 10'd1023) begin
                    address <= 10'd0;
                end
            end
            else begin
                address <= 10'd0;
                ena <= 0;
                wea <= 0;
                tvaild<=0;
            end

        end
    end

    reg parallel_s_axis_tvalid_ref_temp1;
    reg parallel_s_axis_tvalid_ref_temp2;
    wire pos_parallel_s_axis_tvalid_ref;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            parallel_s_axis_tvalid_ref_temp1 <= 0;
            parallel_s_axis_tvalid_ref_temp2 <= 0;
        end
        else begin
            parallel_s_axis_tvalid_ref_temp1 <= parallel_s_axis_tvalid_ref;
            parallel_s_axis_tvalid_ref_temp2 <= parallel_s_axis_tvalid_ref_temp1;
        end
    end
    assign pos_parallel_s_axis_tvalid_ref = parallel_s_axis_tvalid_ref_temp1 && (~parallel_s_axis_tvalid_ref_temp2);

    wire readonce_1st;
    assign readonce_1st =(delay == 4'd5)? 1:0;
    always@(posedge clk_240M or negedge rstn) begin
        if (!rstn) begin
            writeonce <= 0;
            readonce <= 0;
        end
        else begin
            if (address == 10'd1023) begin
                writeonce <= 0;
                readonce <= 0;
            end
            else if (GCC_PHAT_m_axis_tvalid || readonce_1st) begin
                readonce <= 1;
                writeonce <= 0;
            end
            else if (pos_parallel_s_axis_tvalid_ref) begin
                writeonce <= 1;
                readonce <= 0;
            end
        end
    end
    assign serial_m_axis_tready =1;
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

                 .GCC_PHAT_m_axis_tvalid(GCC_PHAT_m_axis_tvalid),
                 .GCC_PHAT_m_axis_tdata(GCC_PHAT_m_axis_tdata)
             );

    //ila_0 ila_1 (
    //          .clk(clk_240M), // input wire clk
    //          .probe0(GCC_PHAT_CH1_s_axis_tvalid), // input wire [0:0]  probe0
    //          .probe1(GCC_PHAT_CH1_s_axis_tdata), // input wire [15:0]  probe1
    //          .probe2(GCC_PHAT_CH1_s_axis_tlast), // input wire [0:0]  probe2
    //          .probe3(GCC_PHAT_CH2_s_axis_tvalid), // input wire [0:0]  probe3
    //          .probe4(GCC_PHAT_CH2_s_axis_tdata), // input wire [15:0]  probe4
    //          .probe5(GCC_PHAT_CH2_s_axis_tlast), // input wire [0:0]  probe5
    //          .probe6(GCC_PHAT_m_axis_tvalid), // input wire [0:0]  probe6
    //          .probe7(GCC_PHAT_m_axis_tdata) // input wire [15:0]  probe7
    //      );

endmodule
