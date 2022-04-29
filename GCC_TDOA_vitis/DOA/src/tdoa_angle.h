/*
 * @Author: zengzhengqi
 * @Description:
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:44:39
 * @FilePath: \DOA\src\tdoa_angle.h
 */
#ifndef _TDOA_ANGLE_H
#define _TDOA_ANGLE_H
#include "easyMatrix.h"
#include "math.h"
#include "stdio.h"
#include "stdlib.h"
#include "float.h"

void tdoa_angleint(double *angle, int *delay, int n, double mic[9][3], int fs);

#endif
