/*
 * @Author: zengzhengqi
 * @Description: 
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:32:04
 * @FilePath: \src\init.c
 */
#include "stdio.h"
#include "xparameters.h"
#include "sleep.h"
#include "xil_types.h"
#include "platform.h"
#include "xil_printf.h"
#include "init.h"
#include "xil_io.h"
#include "xbram.h"
#include "xscugic.h"
#include "tdoa_angle.h"
#include "led.h"

static XScuGic INTCInst;

#define N 9 //麦克风个数
#define FS 48000
#define pos 0.0282842712
#define DDR_BASEARDDR XPAR_DDR_MEM_BASEADDR + 0x10000000
#define START_ADDR 0	 // RAM 起始地址 范围:0~1023
#define BRAM_DATA_BYTE 4 // BRAM 数据字节个数
#define DATA_NUM 8
DATA_TYPE mic[9][3] = {0, -0.04, 0,
					   -pos, -pos, 0,
					   -0.04, 0, 0,
					   -pos, pos, 0,
					   0, 0.04, 0,
					   pos, pos, 0,
					   0.04, 0, 0,
					   pos, -pos, 0,
					   0, 0, 0}; //

signed long int temp;
int databuffer[DATA_NUM];
double angle[2];
int data_vaild;
void rd_bram(int *databuffer)
{
	int i = 0;
	int j = 0;
	unsigned int temp;
	int delay;
	data_vaild = 1;
	//循环从 BRAM 中读出数据
	for (i = BRAM_DATA_BYTE * START_ADDR; i < BRAM_DATA_BYTE * (START_ADDR + DATA_NUM); i += BRAM_DATA_BYTE)
	{
		j = i / 4;
		temp = XBram_ReadReg(XPAR_BRAM_0_BASEADDR, i);
		if (temp > 1024)
		{
			delay = temp - 2049;
		}
		else if (temp <= 1024)
		{
			delay = temp - 1;
		}

		if (delay < -6 || delay > 6)
		{
			data_vaild = 0;
		}

		if (j == 0)
		{
			databuffer[j] = -delay;
		}
		else
		{
			databuffer[8 - j] = -delay;
		}
	}
}
//---------------------------------------------------------
// 中断处理程序
//---------------------------------------------------------
static void read_intr_Handler(void *CallbackRef)
{

	rd_bram(databuffer);
	if (data_vaild)
	{
		tdoa_angle(angle, databuffer, N, mic, FS);
		angle_display((int)angle[0]);
		printf("Yaw:%3dPitch:%3dE\n", (int)angle[0], (int)angle[1]);
	}
}

//---------------------------------------------------------
// 中断敏感类型设置函数
//---------------------------------------------------------
void IntcTypeSetup(XScuGic *InstancePtr, int intId, int intType)
{
	int mask;

	intType &= INT_TYPE_MASK;
	mask = XScuGic_DistReadReg(InstancePtr, INT_CFG0_OFFSET + (intId / 16) * 4);
	mask &= ~(INT_TYPE_MASK << (intId % 16) * 2);
	mask |= intType << ((intId % 16) * 2);
	XScuGic_DistWriteReg(InstancePtr, INT_CFG0_OFFSET + (intId / 16) * 4, mask);
}

//---------------------------------------------------------
// 中断初始化函数
//---------------------------------------------------------
int IntcInitFunction(u16 DeviceId)
{
	XScuGic_Config *IntcConfig; //存储中断设备的配置信息
	int status;

	/* 初始化中断控制器 */
	IntcConfig = XScuGic_LookupConfig(DeviceId);
	status = XScuGic_CfgInitialize(&INTCInst, IntcConfig, IntcConfig->CpuBaseAddress);
	if (status != XST_SUCCESS)
		return XST_FAILURE; //检测初始化状态

	/* 设置并打开中断异常处理功能 */
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								 (Xil_ExceptionHandler)XScuGic_InterruptHandler, &INTCInst);
	Xil_ExceptionEnable();

	/* 为中断设置中断处理函数 */

	status = XScuGic_Connect(&INTCInst, READ_INT_ID,
							 (Xil_ExceptionHandler)read_intr_Handler, (void *)1);
	if (status != XST_SUCCESS)
		return XST_FAILURE;

	/* 将中断设置为上升沿敏感类型 */
	IntcTypeSetup(&INTCInst, READ_INT_ID, INT_TYPE_RISING_EDGE);

	/* 使能中断 */
	XScuGic_Enable(&INTCInst, READ_INT_ID);

	return XST_SUCCESS;
}
