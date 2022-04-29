/*
 * @Author: zengzhengqi
 * @Description:
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:36:21
 * @FilePath: \src\led.h
 */
#ifndef _LED_H
#define _LED_H

#include "xgpio.h"
#include <math.h>
#include <stdio.h>
#include "sleep.h"
XGpio LED;
#define LED_CHANNEL 1

void init_led();
void cycle_display();
void clean_display();

#endif
