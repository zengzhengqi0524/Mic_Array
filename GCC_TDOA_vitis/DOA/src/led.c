/*
 * @Author: zengzhengqi
 * @Description:
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:36:17
 * @FilePath: \src\led.c
 */
#include "led.h"

void init_led()
{

	int Status;
	Status = XGpio_Initialize(&LED, XPAR_GPIO_0_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}

	XGpio_SetDataDirection(&LED, LED_CHANNEL, 0x00000000);
}
void cycle_display()
{
	int i, j;
	for (j = 0; j < 1; j++)
	{
		for (i = 0; i < 12; i++)
		{
			XGpio_DiscreteWrite(&LED, LED_CHANNEL, i);
			usleep(200000);
		}
	}
}

void clean_display()
{
	XGpio_DiscreteWrite(&LED, LED_CHANNEL, 15);
}

void angle_display(int yaw)
{
	if (yaw < 15)
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 0);
	}
	else if ((15 <= yaw) && (yaw < 45))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 11);
	}
	else if ((45 <= yaw) && (yaw < 75))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 10);
	}
	else if ((75 <= yaw) && (yaw < 105))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 9);
	}
	else if ((105 <= yaw) && (yaw < 135))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 8);
	}
	else if ((135 <= yaw) && (yaw < 165))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 7);
	}
	else if ((165 <= yaw) && (yaw < 195))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 6);
	}
	else if ((195 <= yaw) && (yaw < 225))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 5);
	}
	else if ((225 <= yaw) && (yaw < 255))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 4);
	}
	else if ((255 <= yaw) && (yaw < 285))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 3);
	}
	else if ((285 <= yaw) && (yaw < 315))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 2);
	}
	else if ((315 <= yaw) && (yaw < 345))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 1);
	}
	else if ((345 <= yaw) && (yaw <= 360))
	{
		XGpio_DiscreteWrite(&LED, LED_CHANNEL, 0);
	}
}
