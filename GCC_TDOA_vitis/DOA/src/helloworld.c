/*
 * @Author: 
 * @Description: 
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:35:57
 * @FilePath: \src\helloworld.c
 */
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_io.h"
#include "xil_types.h"
#include "platform.h"
#include "xil_printf.h"
#include "init.h"
#include "xil_io.h"
#include "led.h"
int main()
{
    init_platform();
    init_led();
    cycle_display();
    clean_display();
    IntcInitFunction(INTC_DEVICE_ID);
    while (1){}
    cleanup_platform();
    return 0;
}
