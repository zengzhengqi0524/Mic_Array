/*
 * @Author: zengzhengqi
 * @Description:
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 16:00:12
 * @FilePath: \src\tdoa_angle.c
 */
#include "tdoa_angle.h"
void tdoa_angle(double *angle, int *delay, int n, double mic[9][3], int fs) // wei:时延（未除采样率前）；n:麦克风个数；mic:麦克风坐标；fs:采样率
{
    double pi = 3.1415926;
    DATA_TYPE A[n - 1][3]; //生成计算所需要的矩阵，这里MATRIX_TYPE为double型
    DATA_TYPE _B[n - 1][2];
    DATA_TYPE _s[n - 1][1];
    int i, j;
    int row;    //行
    int column; //列
    double s_angle[2];
    double theta1; //方位角的弧度表示
    double theta;  //方位角的角度表示
    double fai1;   //俯仰角计算中间量
    double fai2;
    double fai3; //俯仰角的弧度表示
    double fai;  //俯仰角的角度表示

    for (i = 0; i < n - 1; i++)
    {
        _s[i][0] = (double)delay[i] / (double)fs * 340 * (-1);
    }
    for (i = 0; i < n - 1; i++)
        for (j = 0; j < 3; j++)
        {
            A[i][j] = mic[i][j] - mic[9][j];
        }
    for (i = 0; i < n - 1; i++)
        for (j = 0; j < 2; j++)
        {
            _B[i][j] = A[i][j];
        }

    row = sizeof(_B) / sizeof(_B[0]);
    column = sizeof(_B[0]) / sizeof(_B[0][0]);
    CREATE_DYNAMIC_MATRIX_ONHEAP(row, column, B, _B);        //
    CREATE_DYNAMIC_MATRIX_ONHEAP(column, row, B_T, NULL);    //
    CREATE_DYNAMIC_MATRIX_ONHEAP(column, column, B_1, NULL); //
    CREATE_DYNAMIC_MATRIX_ONHEAP(column, column, B_2, NULL); //
    CREATE_DYNAMIC_MATRIX_ONHEAP(column, row, B_3, NULL);    //
    CREATE_DYNAMIC_MATRIX_ONHEAP(column, 1, s_angle1, NULL); //
    transMatrix(B, B_T);                                     //矩阵转置
    row = sizeof(_s) / sizeof(_s[0]);
    column = sizeof(_s[0]) / sizeof(_s[0][0]);
    CREATE_DYNAMIC_MATRIX_ONHEAP(row, column, s, _s); //

    multiMatrix(B_T, B, B_1);
    invMatrix(B_1, B_2); //取逆
    multiMatrix(B_2, B_T, B_3);
    multiMatrix(B_3, s, s_angle1);
    /*...................................................*/

    for (i = 0; i < s_angle1->rows; i++)
    {
        for (j = 0; j < s_angle1->cols; j++)
        {
            s_angle[i] = s_angle1->element[i * (s_angle1->cols) + j]; //把矩阵（结构体）中的值放入数组中
        }
    }

    theta1 = atan(s_angle[1] / s_angle[0]); //方位角计算，弧度
    theta = fabs(theta1 / pi * 180.0);      //方位角计算，角度

    /*利用s_angle判断方位角范围，声源来源是哪个象限*/
    if (s_angle[0] < 0 && s_angle[1] > 0)
        theta = theta + 270;
    else if (s_angle[0] < 0 && s_angle[1] < 0)
        theta = 270 - theta;
    else if (s_angle[0] > 0 && s_angle[1] < 0)
        theta = theta + 90;
    else if (s_angle[0] > 0 && s_angle[1] > 0)
        theta = 90 - theta;
        
    if (fabs(s_angle[0]) <= 0.0001 && fabs(s_angle[1]) <= 0.0001) //声源来向在原点正上方的情况
        theta = 0;
    /*...................................................*/

    /*弧度角计算*/
    if (fabs(cos(theta1)) <= 0.001 && fabs(sin(theta1) > 0.001)) //做判断是为了规避分母为0的情况
        fai3 = acos(s_angle[1] / sin(theta1));
    else if (fabs(sin(theta1) <= 0.001) && fabs(cos(theta1)) > 0.001)
        fai3 = acos(s_angle[0] / cos(theta1));
    else if (fabs(sin(theta1) <= 0.001) && fabs(cos(theta1)) <= 0.001)
        fai3 = pi / 2;
    else
    {
        fai1 = acos(s_angle[0] / cos(theta1));
        fai2 = acos(s_angle[1] / sin(theta1));
        fai3 = (fai1 + fai2) / 2;
    }

    fai = fabs(fai3 / pi * 180.0); //转为弧度制
    if (fai > 90)
    {
        fai = 180 - fai; //有时会出现fai大于90°的情况，通过判断取补角解决
    }

    angle[0] = theta; //将角度放到指针中
    angle[1] = fai;
    DELETE_DYNAMIC_MATRIX(B_T);
    DELETE_DYNAMIC_MATRIX(B_1);
    DELETE_DYNAMIC_MATRIX(B_2);
    DELETE_DYNAMIC_MATRIX(B_3);
    DELETE_DYNAMIC_MATRIX(s_angle1);
    DELETE_DYNAMIC_MATRIX(B);
    DELETE_DYNAMIC_MATRIX(s);
}