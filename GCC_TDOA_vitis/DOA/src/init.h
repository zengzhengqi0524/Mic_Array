/*
 * @Author:
 * @Description:
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:30:40
 * @FilePath: \src\init.h
 */
#ifndef _INIT_H_
#define _INIT_H_

#include "xil_printf.h"
#include "xscugic.h"
#include "xil_exception.h"

//---------------------------------------------------------
// 参数定义
//---------------------------------------------------------
#define READ_INT_ID 61
#define INTC_DEVICE_ID XPAR_PS7_SCUGIC_0_DEVICE_ID //中断设备
#define INT_TYPE_RISING_EDGE 0x03                  //上升沿敏感
#define INT_TYPE_HIGHLEVEL 0x01                    //高电平敏感
#define INT_TYPE_MASK 0x03
#define INT_CFG0_OFFSET 0x00000C00

//---------------------------------------------------------
// 函数声明
//---------------------------------------------------------
void IntcTypeSetup(XScuGic *InstancePtr, int intId, int intType);
int IntcInitFunction(u16 DeviceId);
#endif
