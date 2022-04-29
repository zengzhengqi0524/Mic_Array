`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/24 13:28:32
// Design Name:
// Module Name: GCC_PHAT
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
module GCC_PHAT(
        rstn,
        clk_240M,
        GCC_PHAT_CH1_s_axis_tvalid,
        GCC_PHAT_CH1_s_axis_tready,
        GCC_PHAT_CH1_s_axis_tdata,
        GCC_PHAT_CH1_s_axis_tlast,

        GCC_PHAT_CH2_s_axis_tvalid,
        GCC_PHAT_CH2_s_axis_tready,
        GCC_PHAT_CH2_s_axis_tdata,
        GCC_PHAT_CH2_s_axis_tlast,

        GCC_PHAT_m_axis_tvalid,
        GCC_PHAT_m_axis_tdata
    );
    input rstn;
    input clk_240M;

    input wire GCC_PHAT_CH1_s_axis_tvalid;
    input wire [15 : 0]GCC_PHAT_CH1_s_axis_tdata;
    input wire GCC_PHAT_CH1_s_axis_tlast;

    input wire GCC_PHAT_CH2_s_axis_tvalid;
    input wire [15 : 0]GCC_PHAT_CH2_s_axis_tdata;
    input wire GCC_PHAT_CH2_s_axis_tlast;
    //output
    output GCC_PHAT_CH1_s_axis_tready;
    output GCC_PHAT_CH2_s_axis_tready;

    output GCC_PHAT_m_axis_tvalid;
    output  [15 : 0]   GCC_PHAT_m_axis_tdata;

    wire combiner_m_axis_tready;
    wire combiner_m_axis_tvalid;
    wire [31: 0]combiner_m_axis_tdata;
    wire combiner_m_axis_tlast;
    wire [1:0]combiner_s_axis_tready;
    assign GCC_PHAT_CH2_s_axis_tready = combiner_s_axis_tready[1];
    assign GCC_PHAT_CH1_s_axis_tready = combiner_s_axis_tready[0];
    //combiner
    axis_combiner_0 axis_combiner_0_0 (
                        .aclk(clk_240M),                    // input wire aclk
                        .aresetn(rstn),              // input wire aresetn
                        .s_axis_tvalid({GCC_PHAT_CH2_s_axis_tvalid,GCC_PHAT_CH1_s_axis_tvalid}),  // input wire [1 : 0] s_axis_tvalid
                        .s_axis_tready(combiner_s_axis_tready),  // output wire [1 : 0] s_axis_tready
                        .s_axis_tdata({GCC_PHAT_CH2_s_axis_tdata,GCC_PHAT_CH1_s_axis_tdata}),    // input wire [31 : 0] s_axis_tdata
                        .s_axis_tlast({GCC_PHAT_CH2_s_axis_tlast,GCC_PHAT_CH1_s_axis_tlast}),    // input wire [1 : 0] s_axis_tlast
                        .m_axis_tvalid(combiner_m_axis_tvalid),  // output wire m_axis_tvalid
                        .m_axis_tready(combiner_m_axis_tready),  // input wire m_axis_tready
                        .m_axis_tdata(combiner_m_axis_tdata),    // output wire [31: 0] m_axis_tdata
                        .m_axis_tlast(combiner_m_axis_tlast)    // output wire m_axis_tlast
                    );
    wire addzero_m_axis_tvalid;
    wire [31 : 0]addzero_m_axis_tdata;
    wire addzero_m_axis_tlast;
    addzero addzero_0(
                .clk_240M(clk_240M),                                        // input wire aclk
                .rstn(rstn),
                .addzero_s_axis_tvalid(combiner_m_axis_tvalid),
                .addzero_s_axis_tdata(combiner_m_axis_tdata),
                .addzero_s_axis_tlast(combiner_m_axis_tlast),
                .addzero_m_axis_tvalid(addzero_m_axis_tvalid),
                .addzero_m_axis_tdata(addzero_m_axis_tdata),
                .addzero_m_axis_tlast(addzero_m_axis_tlast)
            );
    //FFT
    //config
    //wire [47 : 0]fft_s_axis_config_tdata;
    wire [7 : 0]fft_s_axis_config_tdata;
    wire fft_s_axis_config_tvalid;
    wire fft_s_axis_config_tready;
    //wire [21:0]s_axis_config_tdata_c0_scale_sch = 22'b0001010101010101010101; //缩放2^10 = 1024
    //wire [21:0]s_axis_config_tdata_c1_scale_sch = 22'b0001010101010101010101;
    wire s_axis_config_tdata_c0_fwd_inv = 1'b1;
    wire s_axis_config_tdata_c1_fwd_inv = 1'b1;
    //assign fft_s_axis_config_tdata = {2'b0,s_axis_config_tdata_c1_scale_sch,s_axis_config_tdata_c0_scale_sch,s_axis_config_tdata_c1_fwd_inv,s_axis_config_tdata_c0_fwd_inv};//定义FFT模块配置信息(第0位为1表示用FFT，为0表示用IFFT)
    assign fft_s_axis_config_tdata = {6'b0,s_axis_config_tdata_c1_fwd_inv,s_axis_config_tdata_c0_fwd_inv};
    assign fft_s_axis_config_tvalid = 1'd1;//FFT模块配置使能，从一开始就拉高，表示已经准备好要传入的配置数据了
    //input
    wire [63 : 0]fft_s_axis_data_tdata;
    wire fft_s_axis_data_tvalid;
    wire fft_s_axis_data_tready;
    wire fft_s_axis_data_tlast;
    assign fft_s_axis_data_tdata = {16'b0,addzero_m_axis_tdata[31:16],16'b0,addzero_m_axis_tdata[15:0]};
    assign fft_s_axis_data_tvalid = addzero_m_axis_tvalid;
    assign fft_s_axis_data_tlast = addzero_m_axis_tlast;
    assign combiner_m_axis_tready = fft_s_axis_data_tready;
    //output
    wire [127 : 0]fft_m_axis_data_tdata;// output wire [127 : 0] m_axis_data_tdata  123:96 91:64 59:32 27:0
    wire [15 : 0]fft_m_axis_data_tuser;             // output wire [15 : 0] m_axis_data_tuser//[9:0]XK_INDEX
    wire fft_m_axis_data_tvalid;                   // output wire m_axis_data_tvalid
    wire fft_m_axis_data_tready;                   // input wire m_axis_data_tready
    wire fft_m_axis_data_tlast;                     // output wire m_axis_data_tlast
    assign fft_m_axis_data_tready = 1;
    //flag
    wire fft_event_frame_started;
    wire fft_event_tlast_unexpected;
    wire fft_event_tlast_missing;
    wire fft_event_status_channel_halt;
    wire fft_event_data_in_channel_halt;
    wire fft_event_data_out_channel_halt;
    xfft_0 fft_0 (
               .aclk(clk_240M),                                                // input wire aclk
               .aresetn(rstn),                                                  // input wire aresetn
               .s_axis_config_tdata(fft_s_axis_config_tdata),                  // input wire [47 : 0] s_axis_config_tdata
               .s_axis_config_tvalid(fft_s_axis_config_tvalid),                // input wire s_axis_config_tvalid
               .s_axis_config_tready(fft_s_axis_config_tready),                // output wire s_axis_config_tready
               .s_axis_data_tdata(fft_s_axis_data_tdata),// input wire [127 : 0] s_axis_data_tdata
               .s_axis_data_tvalid(fft_s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
               .s_axis_data_tready(fft_s_axis_data_tready),                    // output wire s_axis_data_tready
               .s_axis_data_tlast(fft_s_axis_data_tlast),                      // input wire s_axis_data_tlast
               .m_axis_data_tdata(fft_m_axis_data_tdata),                      // output wire [127 : 0] m_axis_data_tdata
               .m_axis_data_tuser(fft_m_axis_data_tuser),                      // output wire [15 : 0] m_axis_data_tuser//[9:0]xk_index
               .m_axis_data_tvalid(fft_m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
               .m_axis_data_tready(fft_m_axis_data_tready),                    // input wire m_axis_data_tready
               .m_axis_data_tlast(fft_m_axis_data_tlast),                      // output wire m_axis_data_tlast

               .event_frame_started(fft_event_frame_started),                  // output wire event_frame_started
               .event_tlast_unexpected(fft_event_tlast_unexpected),            // output wire event_tlast_unexpected
               .event_tlast_missing(fft_event_tlast_missing),                  // output wire event_tlast_missing
               .event_status_channel_halt(fft_event_status_channel_halt),      // output wire event_status_channel_halt
               .event_data_in_channel_halt(fft_event_data_in_channel_halt),    // output wire event_data_in_channel_halt
               .event_data_out_channel_halt(fft_event_data_out_channel_halt)  // output wire event_data_out_channel_halt
           );


    //互功率谱
    wire cmpy_s_axis_a_tvalid;       // input wire s_axis_a_tvalid
    wire cmpy_s_axis_a_tlast;         // input wire s_axis_a_tlast
    wire [63 : 0]cmpy_s_axis_a_tdata;          // input wire [31 : 0] s_axis_a_tdata
    wire cmpy_s_axis_b_tvalid;        // input wire s_axis_b_tvalid
    wire cmpy_s_axis_b_tlast;          // input wire s_axis_b_tlast
    wire [63 : 0]cmpy_s_axis_b_tdata;          // input wire [31 : 0] s_axis_b_tdata
    wire cmpy_m_axis_dout_tvalid;  // output wire m_axis_dout_tvalid
    wire cmpy_m_axis_dout_tlast;    // output wire m_axis_dout_tlast
    wire [127 : 0]cmpy_m_axis_dout_tdata;   // output wire [63  : 0] m_axis_dout_tdata//120:64 56:0
    assign cmpy_s_axis_a_tdata =fft_m_axis_data_tdata[63:0];
    //有一个通道需要求共轭，哪个信号做参考就哪个信号取共轭 ch2（高位）为参考
    wire [27:0]data_im_neg;
    assign data_im_neg = fft_m_axis_data_tdata[123]==0 ? ~(fft_m_axis_data_tdata[123:96])+1'b1 :  ~(fft_m_axis_data_tdata[123:96] - 1'b1);//求虚部数据(补码)的相反数(补码)
    assign cmpy_s_axis_b_tdata = {fft_m_axis_data_tdata[127:124],data_im_neg , fft_m_axis_data_tdata[95:64]};

    assign cmpy_s_axis_a_tvalid = fft_m_axis_data_tvalid;
    assign cmpy_s_axis_b_tvalid = fft_m_axis_data_tvalid;
    assign cmpy_s_axis_a_tlast = fft_m_axis_data_tlast;
    assign cmpy_s_axis_b_tlast = fft_m_axis_data_tlast;
    cmpy_1 cmpy_1_0 (
               .aclk(clk_240M),                              // input wire aclk
               .aresetn(rstn),                              // input wire aresetn
               .s_axis_a_tvalid(cmpy_s_axis_a_tvalid),        // input wire s_axis_a_tvalid
               .s_axis_a_tlast(cmpy_s_axis_a_tlast),          // input wire s_axis_a_tlast
               .s_axis_a_tdata(cmpy_s_axis_a_tdata),          // input wire [55 : 0] s_axis_a_tdata
               .s_axis_b_tvalid(cmpy_s_axis_b_tvalid),        // input wire s_axis_b_tvalid
               .s_axis_b_tlast(cmpy_s_axis_b_tlast),          // input wire s_axis_b_tlast
               .s_axis_b_tdata(cmpy_s_axis_b_tdata),          // input wire [55 : 0] s_axis_b_tdata
               .m_axis_dout_tvalid(cmpy_m_axis_dout_tvalid),  // output wire m_axis_dout_tvalid
               .m_axis_dout_tlast(cmpy_m_axis_dout_tlast),    // output wire m_axis_dout_tlast
               .m_axis_dout_tdata(cmpy_m_axis_dout_tdata)    // output wire [63 : 0] m_axis_dout_tdata
           );
    //复数乘法结果截位
    wire [63 : 0]cmpy_m_axis_tdata;
    assign cmpy_m_axis_tdata = {cmpy_m_axis_dout_tdata[120],cmpy_m_axis_dout_tdata[106:76],cmpy_m_axis_dout_tdata[56],cmpy_m_axis_dout_tdata[42:12]};
    //互功率谱加权(3step)
    //////////////////////////////////////方法一///////////////////////////////////////
    //arctan求角度
    wire arctan_m_axis_dout_tvalid;
    wire arctan_m_axis_dout_tlast;
    wire [31 : 0]arctan_m_axis_dout_tdata;//fix32_29
    cordic_1 cordic_1_arctan (
                 .aclk(clk_240M),                                        // input wire aclk
                 .aresetn(rstn),                                  // input wire aresetn
                 .s_axis_cartesian_tvalid(cmpy_m_axis_dout_tvalid),  // input wire s_axis_cartesian_tvalid
                 .s_axis_cartesian_tlast(cmpy_m_axis_dout_tlast),    // input wire s_axis_cartesian_tlast
                 .s_axis_cartesian_tdata(cmpy_m_axis_tdata),    // input wire [63 : 0] s_axis_cartesian_tdata fix32_30
                 .m_axis_dout_tvalid(arctan_m_axis_dout_tvalid),            // output wire m_axis_dout_tvalid
                 .m_axis_dout_tlast(arctan_m_axis_dout_tlast),              // output wire m_axis_dout_tlast
                 .m_axis_dout_tdata(arctan_m_axis_dout_tdata)              // output wire [31 : 0] m_axis_dout_tdata  fix16_13
             );
    // 角度归一化向量
    wire sincos_m_axis_dout_tvalid;
    wire sincos_m_axis_dout_tlast;
    wire [63 : 0]sincos_m_axis_dout_tdata;
    cordic_2 cordic_2_sincos (
                 .aclk(clk_240M),                                // input wire aclk
                 .aresetn(rstn),                          // input wire aresetn
                 .s_axis_phase_tvalid(arctan_m_axis_dout_tvalid),  // input wire s_axis_phase_tvalid
                 .s_axis_phase_tlast(arctan_m_axis_dout_tlast),    // input wire s_axis_phase_tlast
                 .s_axis_phase_tdata(arctan_m_axis_dout_tdata),    // input wire [31 : 0] s_axis_phase_tdata
                 .m_axis_dout_tvalid(sincos_m_axis_dout_tvalid),    // output wire m_axis_dout_tvalid
                 .m_axis_dout_tlast(sincos_m_axis_dout_tlast),      // output wire m_axis_dout_tlast
                 .m_axis_dout_tdata(sincos_m_axis_dout_tdata)      // output wire [63 : 0] m_axis_dout_tdata
             );
    ////////////////////////////////////////方法二///////////////////////////////////////
    ////1.求模
    //wire mod_m_axis_tlast;
    //wire mod_m_axis_tvalid;
    //wire [31 : 0]mod_m_axis_tdata;
    //wire [63 : 0]mod_m_axis_dout_tdata;
    //assign mod_m_axis_tdata = mod_m_axis_dout_tdata[31:0];
    //cordic_0 mod_0 (
    //             .aclk(clk_240M),                                        // input wire aclk
    //             .aresetn(rstn),                                  // input wire aresetn
    //             .s_axis_cartesian_tvalid(cmpy_m_axis_dout_tvalid),  // input wire s_axis_cartesian_tvalid
    //             .s_axis_cartesian_tlast(cmpy_m_axis_dout_tlast),    // input wire s_axis_cartesian_tlast
    //             .s_axis_cartesian_tdata(cmpy_m_axis_tdata),    // input wire [63 : 0] s_axis_cartesian_tdata
    //             .m_axis_dout_tvalid(mod_m_axis_tvalid),            // output wire m_axis_dout_tvalid
    //             .m_axis_dout_tlast(mod_m_axis_tlast),              // output wire m_axis_dout_tlast
    //             .m_axis_dout_tdata(mod_m_axis_dout_tdata)              // output wire [63 : 0] m_axis_dout_tdata
    //         );
    ////2.delay
    //wire [63 :0]delay_m_axis_tdata;
    //wire delay_m_axis_tvalid;
    //wire delay_m_axis_tlast;
    //axis_delay axis_delay_0(
    //               .rstn(rstn),
    //               .clk_240M(clk_240M),
    //               .delay_s_axis_tvalid(cmpy_m_axis_dout_tvalid),
    //               .delay_s_axis_tdata(cmpy_m_axis_tdata),
    //               .delay_s_axis_tlast(cmpy_m_axis_dout_tlast),

    //               .delay_m_axis_tvalid(delay_m_axis_tvalid),
    //               .delay_m_axis_tdata(delay_m_axis_tdata),
    //               .delay_m_axis_tlast(delay_m_axis_tlast)
    //           );
    ////3.divide 分成实部和虚部分别除以模，然后合并成ifft数据,由于结果必定-1<=ans<=1
    //// input
    ////防止除数为0
    //wire [31 : 0]im_s_axis_divisor_tdata;
    //assign im_s_axis_divisor_tdata = (mod_m_axis_tdata==32'b0)? mod_m_axis_tdata + 32'b1 : mod_m_axis_tdata;
    //wire [31 : 0]re_s_axis_divisor_tdata;
    //assign re_s_axis_divisor_tdata = im_s_axis_divisor_tdata;

    //wire divide_im_m_axis_dout_tvalid;
    //wire divide_im_m_axis_dout_tlast;
    //wire [63 : 0]divide_im_m_axis_dout_tdata;//63:32整数 31:0小数
    //wire divide_re_m_axis_dout_tvalid;
    //wire divide_re_m_axis_dout_tlast;
    //wire [63 : 0]divide_re_m_axis_dout_tdata;//63:32整数 31:0小数
    //div_gen_0 div_gen_0_im (
    //              .aclk(clk_240M),                                      // input wire aclk
    //              .aresetn(rstn),                                // input wire aresetn
    //              .s_axis_divisor_tvalid(mod_m_axis_tvalid),    // input wire s_axis_divisor_tvalid
    //              .s_axis_divisor_tdata(im_s_axis_divisor_tdata),      // input wire [31 : 0] s_axis_divisor_tdata
    //              .s_axis_dividend_tvalid(delay_m_axis_tvalid),  // input wire s_axis_dividend_tvalid
    //              .s_axis_dividend_tlast(delay_m_axis_tlast),    // input wire s_axis_dividend_tlast
    //              .s_axis_dividend_tdata(delay_m_axis_tdata [63:32]),    // input wire [31 : 0] s_axis_dividend_tdata
    //              .m_axis_dout_tvalid(divide_im_m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
    //              .m_axis_dout_tlast(divide_im_m_axis_dout_tlast),            // output wire m_axis_dout_tlast
    //              .m_axis_dout_tdata(divide_im_m_axis_dout_tdata)            // output wire [47 : 0] m_axis_dout_tdata
    //          );
    //div_gen_0 div_gen_0_re (
    //              .aclk(clk_240M),                                      // input wire aclk
    //              .aresetn(rstn),                                // input wire aresetn
    //              .s_axis_divisor_tvalid(mod_m_axis_tvalid),    // input wire s_axis_divisor_tvalid
    //              .s_axis_divisor_tdata(re_s_axis_divisor_tdata),      // input wire [31 : 0] s_axis_divisor_tdata
    //              .s_axis_dividend_tvalid(delay_m_axis_tvalid),  // input wire s_axis_dividend_tvalid
    //              .s_axis_dividend_tlast(delay_m_axis_tlast),    // input wire s_axis_dividend_tlast
    //              .s_axis_dividend_tdata(delay_m_axis_tdata [31:0]),    // input wire [31 : 0] s_axis_dividend_tdata
    //              .m_axis_dout_tvalid(divide_re_m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
    //              .m_axis_dout_tlast(divide_re_m_axis_dout_tlast),            // output wire m_axis_dout_tlast
    //              .m_axis_dout_tdata(divide_re_m_axis_dout_tdata)            // output wire [47 : 0] m_axis_dout_tdata
    //          );


    //reg[31 : 0] ifft_s_axis_data_tdata_re;
    //reg[31 : 0] ifft_s_axis_data_tdata_im;
    //always@(*)begin
    //    if (divide_re_m_axis_dout_tdata[63:32]==32'hffff_ffff)begin
    //        ifft_s_axis_data_tdata_re = {divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[30:1]}+ 32'hC000_0000;
    //    end
    //    else if(divide_re_m_axis_dout_tdata[63:32]==32'h0000_0001)begin
    //        ifft_s_axis_data_tdata_re = {divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[30:1]}+ 32'h4000_0000;
    //    end
    //    else if(divide_re_m_axis_dout_tdata[63:32]==32'h0000_0000)begin
    //        ifft_s_axis_data_tdata_re={divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[31],divide_re_m_axis_dout_tdata[30:1]} ;
    //    end
    //end
    //always@(*)begin
    //    if (divide_im_m_axis_dout_tdata[63:32]==32'hffff_ffff)begin
    //        ifft_s_axis_data_tdata_im =  {divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[30:1]}+ 32'hC000_0000;
    //    end
    //    else if(divide_im_m_axis_dout_tdata[63:32]==32'h0000_0001)begin
    //        ifft_s_axis_data_tdata_im = {divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[30:1]}+32'h4000_0000;
    //    end
    //    else if(divide_im_m_axis_dout_tdata[63:32]==32'h0000_0000) begin
    //        ifft_s_axis_data_tdata_im={divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[31],divide_im_m_axis_dout_tdata[30:1]} ;
    //    end
    //end
    //wire [63 : 0] ifft_s_axis_data_tdata;                    // input wire [63 : 0] s_axis_data_tdata
    //assign ifft_s_axis_data_tdata = {ifft_s_axis_data_tdata_im,ifft_s_axis_data_tdata_re};
    ////////////////////////////////////////方法二END///////////////////////////////////////

    //IFFT
    //config
    wire ifft_s_axis_config_tvalid;
    wire ifft_s_axis_config_tready;
    //wire [23 : 0]ifft_s_axis_config_tdata;
    //wire ifft_s_axis_config_tdata_scale_sch = 20'b01010101010101010110;
    //wire ifft_s_axis_config_tdata_fwd_inv = 1'b0;
    //assign ifft_s_axis_config_tdata = {3'b0,ifft_s_axis_config_tdata_scale_sch,ifft_s_axis_config_tdata_fwd_inv};//定义FFT模块配置信息(第0位为1表示用FFT，为0表示用IFFT)
    wire [7 : 0]ifft_s_axis_config_tdata;
    wire ifft_s_axis_config_tdata_fwd_inv = 1'b0;
    assign ifft_s_axis_config_tdata = {7'b0,ifft_s_axis_config_tdata_fwd_inv};//定义FFT模块配置信息(第0位为1表示用FFT，为0表示用IFFT)
    assign ifft_s_axis_config_tvalid = 1'd1;//FFT模块配置使能，从一开始就拉高，表示已经准备好要传入的配置数据了
    //input

    //IFFT
    wire [63:0]ifft_s_axis_data_tdata;
    wire ifft_s_axis_data_tvalid;                  // input wire s_axis_data_tvalid
    wire ifft_s_axis_data_tready;                    // output wire s_axis_data_tready
    wire ifft_s_axis_data_tlast;                     // input wire s_axis_data_tlast
    assign ifft_s_axis_data_tvalid = sincos_m_axis_dout_tvalid;
    assign ifft_s_axis_data_tlast = sincos_m_axis_dout_tlast;
    assign ifft_s_axis_data_tdata = sincos_m_axis_dout_tdata;
    //output
    wire [95 : 0]ifft_m_axis_data_tdata;            // output wire [95 : 0] m_axis_data_tdata//91:48 43:0
    wire [15 : 0]ifft_m_axis_data_tuser;             // output wire [15 : 0] m_axis_data_tuser//[9:0]XK_INDEX
    wire ifft_m_axis_data_tvalid;                   // output wire m_axis_data_tvalid
    wire ifft_m_axis_data_tready;                   // input wire m_axis_data_tready
    wire ifft_m_axis_data_tlast;                     // output wire m_axis_data_tlast
    assign ifft_m_axis_data_tready = 1;

    wire ifft_event_frame_started;
    wire ifft_event_tlast_unexpected;
    wire ifft_event_tlast_missing;
    wire ifft_event_status_channel_halt;
    wire ifft_event_data_in_channel_halt;
    wire ifft_event_data_out_channel_halt;
    xfft_1 ifft_0 (
               .aclk(clk_240M),                                                // input wire aclk
               .aresetn(rstn),                                          // input wire aresetn
               .s_axis_config_tdata(ifft_s_axis_config_tdata),                  // input wire [23 : 0] s_axis_config_tdata
               .s_axis_config_tvalid(ifft_s_axis_config_tvalid),                // input wire s_axis_config_tvalid
               .s_axis_config_tready(ifft_s_axis_config_tready),                // output wire s_axis_config_tready
               .s_axis_data_tdata(ifft_s_axis_data_tdata),                      // input wire [63 : 0] s_axis_data_tdata
               .s_axis_data_tvalid(ifft_s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
               .s_axis_data_tready(ifft_s_axis_data_tready),                    // output wire s_axis_data_tready
               .s_axis_data_tlast(ifft_s_axis_data_tlast),                      // input wire s_axis_data_tlast

               .m_axis_data_tdata(ifft_m_axis_data_tdata),                      // output wire [95 : 0] m_axis_data_tdata
               .m_axis_data_tuser(ifft_m_axis_data_tuser),                      // output wire [15 : 0] m_axis_data_tuser
               .m_axis_data_tvalid(ifft_m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
               .m_axis_data_tready(ifft_m_axis_data_tready),                    // input wire m_axis_data_tready
               .m_axis_data_tlast(ifft_m_axis_data_tlast),                      // output wire m_axis_data_tlast

               .event_frame_started(ifft_event_frame_started),                  // output wire event_frame_started
               .event_tlast_unexpected(ifft_event_tlast_unexpected),            // output wire event_tlast_unexpected
               .event_tlast_missing(ifft_event_tlast_missing),                  // output wire event_tlast_missing
               .event_status_channel_halt(ifft_event_status_channel_halt),      // output wire event_status_channel_halt
               .event_data_in_channel_halt(ifft_event_data_in_channel_halt),    // output wire event_data_in_channel_halt
               .event_data_out_channel_halt(ifft_event_data_out_channel_halt)  // output wire event_data_out_channel_halt
           );

    wire [63 : 0]gcc_m_axis_dout_tdata;
    wire gcc_m_axis_dout_tlast;
    wire gcc_m_axis_dout_tvalid;
    cordic_0 cordic_0_1 (
                 .aclk(clk_240M),                                        // input wire aclk
                 .aresetn(rstn),                                  // input wire aresetn
                 .s_axis_cartesian_tvalid(ifft_m_axis_data_tvalid),  // input wire s_axis_cartesian_tvalid
                 .s_axis_cartesian_tlast(ifft_m_axis_data_tlast),    // input wire s_axis_cartesian_tlast
                 .s_axis_cartesian_tdata({ifft_m_axis_data_tdata[91:60],ifft_m_axis_data_tdata[43:12]}),    // input wire [31 : 0] s_axis_cartesian_tdata
                 .m_axis_dout_tvalid(gcc_m_axis_dout_tvalid),            // output wire m_axis_dout_tvalid
                 .m_axis_dout_tlast(gcc_m_axis_dout_tlast),              // output wire m_axis_dout_tlast
                 .m_axis_dout_tdata(gcc_m_axis_dout_tdata)              // output wire [31: 0] m_axis_dout_tdata
             );
    wire [31:0]gcc_mod_m_axis_dout_tdata = gcc_m_axis_dout_tdata[31:0];
    wire findmax_m_axis_tvalid;
    wire [15:0]findmax_m_axis_tdata;
    findmax findmax_0(
                .clk_240M(clk_240M),                                        // input wire aclk
                .rstn(rstn),
                .findmax_s_axis_tvalid(gcc_m_axis_dout_tvalid),
                .findmax_s_axis_tdata(gcc_mod_m_axis_dout_tdata),
                .findmax_s_axis_tlast(gcc_m_axis_dout_tlast),
                .findmax_m_axis_tvalid(findmax_m_axis_tvalid),
                .findmax_m_axis_tdata(findmax_m_axis_tdata)

            );
    assign GCC_PHAT_m_axis_tvalid = findmax_m_axis_tvalid;
    assign GCC_PHAT_m_axis_tdata = findmax_m_axis_tdata;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ila_1 ila_1_0 (
    //           .clk(clk_240M), // input wire clk
    //           .probe0(addzero_m_axis_tdata), // input wire [31:0]  probe0
    //           .probe1(addzero_m_axis_tvaild), // input wire [0:0]  probe1
    //           .probe2(addzero_m_axis_tlast), // input wire [0:0]  probe2
    //           .probe3(cmpy_s_axis_b_tdata), // input wire [30:0]  probe3
    //           .probe4(cmpy_s_axis_b_tvaild), // input wire [0:0]  probe4
    //           .probe5(cmpy_s_axis_b_tlast), // input wire [0:0]  probe5
    //           .probe6(cmpy_m_axis_tdata), // input wire [30:0]  probe6
    //           .probe7(cmpy_m_axis_dout_tvalid), // input wire [0:0]  probe7
    //           .probe8(cmpy_m_axis_dout_tlast),// input wire [0:0]  probe8
    //           .probe9(gcc_mod_m_axis_dout_tdata), // input wire [31:0]  probe9
    //           .probe10(gcc_m_axis_dout_tvalid), // input wire [0:0]  probe10
    //           .probe11(gcc_m_axis_dout_tlast), // input wire [0:0]  probe11
    //           .probe12(findmax_m_axis_tdata), // input wire [15:0]  probe12
    //           .probe13(findmax_m_axis_tvalid) // input wire [0:0]  probe13
    //       );

    //debug
    //integer dout_file;
    //initial begin
    //    dout_file=$fopen("C:/Users/IRON/Desktop/fft.txt","w");    //打开所创建的文件
    //      if(dout_file == 0)begin
    //                $display ("can not open the file!");    //创建文件失败，显示can not open the file!
    //                $stop;
    //       end
    //end
    //always @(posedge clk_240M)begin
    //     if(fft_m_axis_data_tvalid && !fft_m_axis_data_tlast) begin
    //       $fwrite(dout_file,"%d %d %d %d\n",$signed(fft_m_axis_data_tdata[123:96]),$signed(fft_m_axis_data_tdata[91:64]),$signed(fft_m_axis_data_tdata[59:32]),$signed(fft_m_axis_data_tdata[27:0]));    //保存有符号数据
    //       end
    //      else if (fft_m_axis_data_tvalid && fft_m_axis_data_tlast) begin
    //       $fwrite(dout_file,"%d %d %d %d\n",$signed(fft_m_axis_data_tdata[123:96]),$signed(fft_m_axis_data_tdata[91:64]),$signed(fft_m_axis_data_tdata[59:32]),$signed(fft_m_axis_data_tdata[27:0]));    //保存有符号数据
    //        $fclose(dout_file);
    //       end
    // end

    // integer dout_file;
    //initial begin
    //    dout_file=$fopen("C:/Users/IRON/Desktop/cmpy.txt","w");    //打开所创建的文件
    //      if(dout_file == 0)begin
    //                $display ("can not open the file!");    //创建文件失败，显示can not open the file!
    //                $stop;
    //       end
    //end
    //always @(posedge clk_240M)begin
    //     if(cmpy_m_axis_dout_tvalid && !cmpy_s_axis_a_tlast) begin
    //       $fwrite(dout_file,"%d %d\n",$signed(cmpy_m_axis_tdata[63:32]),$signed(cmpy_m_axis_tdata[31:0]));    //保存有符号数据
    //       end
    //      else if (cmpy_m_axis_dout_tvalid && cmpy_s_axis_a_tlast) begin
    //       $fwrite(dout_file,"%d %d\n",$signed(cmpy_m_axis_tdata[63:32]),$signed(cmpy_m_axis_tdata[31:0]));    //保存有符号数据
    //        $fclose(dout_file);
    //       end
    // end

    // integer sincos;
    // initial begin
    //     sincos=$fopen("C:/Users/IRON/Desktop/sincos.txt","w");    //打开所创建的文件
    //     if(sincos == 0)begin
    //         $display ("can not open the file!");    //创建文件失败，显示can not open the file!
    //         $stop;
    //     end
    // end
    // always @(posedge clk_240M)begin
    //     if(sincos_m_axis_dout_tvalid && !sincos_m_axis_dout_tlast) begin
    //         $fwrite(sincos,"%d %d\n",$signed(sincos_m_axis_dout_tdata[63:32]),$signed(sincos_m_axis_dout_tdata[31:0]));    //保存有符号数据
    //     end
    //     else if (sincos_m_axis_dout_tvalid && sincos_m_axis_dout_tlast) begin
    //         $fwrite(sincos,"%d %d\n",$signed(sincos_m_axis_dout_tdata[63:32]),$signed(sincos_m_axis_dout_tdata[31:0]));    //保存有符号数据
    //         $fclose(sincos);
    //     end
    // end

    //  integer divide;
    //initial begin
    //    divide=$fopen("C:/Users/IRON/Desktop/divide.txt","w");    //打开所创建的文件
    //      if(divide == 0)begin
    //                $display ("can not open the file!");    //创建文件失败，显示can not open the file!
    //                $stop;
    //       end
    //end
    //always @(posedge clk_240M)begin
    //     if(divide_re_m_axis_dout_tvalid && !divide_re_m_axis_dout_tlast) begin
    //       $fwrite(divide,"%d %d\n",$signed(ifft_s_axis_data_tdata[63:32]),$signed(ifft_s_axis_data_tdata[31:0]));    //保存有符号数据
    //       end
    //      else if (divide_re_m_axis_dout_tvalid && divide_re_m_axis_dout_tlast) begin
    //       $fwrite(divide,"%d %d\n",$signed(ifft_s_axis_data_tdata[63:32]),$signed(ifft_s_axis_data_tdata[31:0]));    //保存有符号数据
    //        $fclose(divide);
    //       end
    // end

    // integer ifft;
    // initial begin
    //     ifft=$fopen("C:/Users/IRON/Desktop/ifft.txt","w");    //打开所创建的文件
    //     if(ifft == 0)begin
    //         $display ("can not open the file!");    //创建文件失败，显示can not open the file!
    //         $stop;
    //     end
    // end
    // always @(posedge clk_240M)begin
    //     if(ifft_m_axis_data_tvalid && !ifft_m_axis_data_tlast) begin
    //         $fwrite(ifft,"%d %d\n",$signed(ifft_m_axis_data_tdata[91:48]),$signed(ifft_m_axis_data_tdata[43:0]));    //保存有符号数据
    //     end
    //     else if (ifft_m_axis_data_tvalid && ifft_m_axis_data_tlast) begin
    //         $fwrite(ifft,"%d %d\n",$signed(ifft_m_axis_data_tdata[91:48]),$signed(ifft_m_axis_data_tdata[43:0]));    //保存有符号数据
    //         $fclose(ifft);
    //     end
    // end
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
