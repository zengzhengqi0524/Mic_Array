/*
 * @Author: 
 * @Description: 
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:31:03
 * @FilePath: \src\easyMatrix.h
 */
#ifndef _EASYMATRIX_H
#define _EASYMATRIX_H
#include <stdlib.h>
#include <stdio.h>
#include <float.h>
#include <stdlib.h>
typedef unsigned char uint8;
typedef double DATA_TYPE;

#define CREATE_MATRIX_ONSTACK(x, y, matrix, initval) \
    struct easyMatrix matrix;                        \
    DATA_TYPE val##x##N##y##N##matrix[x * y];        \
    matrix.rows = x;                                 \
    matrix.cols = y;                                 \
    matrix.element = val##x##N##y##N##matrix;        \
    if (initval != NULL)                             \
    setMatrix(initval, &(matrix))

#define CREATE_DYNAMIC_MATRIX_ONHEAP(x, y, matrix, initval)                             \
    struct easyMatrix *matrix = (struct easyMatrix *)malloc(sizeof(struct easyMatrix)); \
    matrix->rows = x;                                                                   \
    matrix->cols = y;                                                                   \
    matrix->element = (DATA_TYPE *)malloc(sizeof(DATA_TYPE) * (x) * (y));               \
    if (initval != NULL)                                                                \
    setMatrix(initval, (matrix))

#define DELETE_DYNAMIC_MATRIX(matrix) \
    free((matrix)->element);          \
    free(matrix)

struct easyMatrix
{
    uint8 rows, cols;
    DATA_TYPE *element;
};

struct easyMatrix *setMatrix(DATA_TYPE *a, struct easyMatrix *c);

struct easyMatrix *copyMatrix(struct easyMatrix *const a, struct easyMatrix *c);

struct easyMatrix *transMatrix(struct easyMatrix *const a, struct easyMatrix *c);

DATA_TYPE detMatrix(struct easyMatrix *const a);

DATA_TYPE invMatrix(struct easyMatrix *const a, struct easyMatrix *b);

struct easyMatrix *scaleMatrix(DATA_TYPE, struct easyMatrix *const a, struct easyMatrix *);

struct easyMatrix *addMatrix(const struct easyMatrix *const a, const struct easyMatrix *const b, struct easyMatrix *c);

struct easyMatrix *leftMatrix(uint8, uint8, struct easyMatrix *const a, struct easyMatrix *b);

struct easyMatrix *subMatrix(struct easyMatrix *const a, struct easyMatrix *const b, struct easyMatrix *c);

struct easyMatrix *multiMatrix(struct easyMatrix *const a, struct easyMatrix *const b, struct easyMatrix *c);

struct easyMatrix *zerosMatrix(struct easyMatrix *e);

struct easyMatrix *eyesMatrix(struct easyMatrix *e);

void dumpMatrix(struct easyMatrix *const e);

struct easyMatrix *adjMatrix(struct easyMatrix *const a, struct easyMatrix *c);

struct easyMatrix *getLUMatrix(struct easyMatrix *const A, struct easyMatrix *L, struct easyMatrix *U);

struct easyMatrix *invLMatrix(struct easyMatrix *const L, struct easyMatrix *L_inv);
struct easyMatrix *invUMatrix(struct easyMatrix *const U, struct easyMatrix *U_inv);

DATA_TYPE fastDetMatrix(struct easyMatrix *const in);
#endif //_MAGRIDE_PLANNING_EASYMATRIX_H_
