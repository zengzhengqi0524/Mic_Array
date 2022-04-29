/*
 * @Author: 
 * @Description: 
 * @Date: 2022-01-03 01:10:26
 * @LastEditTime: 2022-04-29 15:28:23
 * @FilePath: \src\easyMatrix.c
 */
#include "easyMatrix.h"
int isFiniteNumber(double d)
{
    return (d <= DBL_MAX && d >= -DBL_MAX);
}
struct easyMatrix *setMatrix(DATA_TYPE *a, struct easyMatrix *c)
{
    int i;
    uint8 x = c->rows;
    uint8 y = c->cols;
    int t = x * y;
    for (i = 0; i < t; ++i)
    {
        c->element[i] = a[i];
    }
    return c;
}

struct easyMatrix *copyMatrix(struct easyMatrix *const a,
                              struct easyMatrix *c)
{
    int i;
    if (a->rows != c->rows)
        return NULL;
    if (a->cols != c->cols)
        return NULL;
    int t = a->rows * a->cols;
    for (i = 0; i < t; ++i)
    {
        c->element[i] = a->element[i];
    }
    return c;
}

struct easyMatrix *transMatrix(struct easyMatrix *const a, 
                               struct easyMatrix *c)
{
    uint8 ii;
    uint8 jj;
    if (a->rows != c->cols)
        return NULL;
    if (a->cols != c->rows)
        return NULL;
    int index = 0;
    int index_src = 0;
    for (ii = 0; ii < a->cols; ++ii)
    {
        index_src = ii;
        for (jj = 0; jj < a->rows; ++jj)
        {
            // c->element[index] = a->element[jj*a->cols+ii];
            c->element[index] = a->element[index_src];
            index++;
            index_src += a->cols;
        }
    }
    return c;
}

struct easyMatrix *leftMatrix(uint8 x_i, uint8 y_i, struct easyMatrix *const in,
                              struct easyMatrix *out)
{
    uint8 kk;
    uint8 ww;
    if (in->rows != in->cols)
        return NULL;
    if (out->rows != out->cols)
        return NULL;
    if (in->rows != (out->rows + 1))
        return NULL;
    int index = 0;
    int index_src = 0;
    uint8 x = in->rows;
    uint8 y = in->cols;
    for (kk = 0; kk < x; ++kk)
    {
        for (ww = 0; ww < y; ++ww)
        {
            if (!(kk == x_i || ww == y_i))
            {
                // out->element[index] = in->element[kk*y+ww];
                out->element[index] = in->element[index_src];
                index++;
            }
            index_src++;
        }
    }
    return out;
}
struct easyMatrix *adjMatrix(struct easyMatrix *const in,
                             struct easyMatrix *out)
{
    uint8 ii;
    uint8 jj;
    if (in->rows != out->cols)
        return NULL;
    if (in->cols != out->rows)
        return NULL;
    int index = 0;
    uint8 x = in->rows;
    uint8 y = in->cols;
    CREATE_DYNAMIC_MATRIX_ONHEAP(x - 1, y - 1, ret, NULL);
    signed char sign1 = 1;
    signed char sign2 = 1;
    for (ii = 0; ii < x; ++ii)
    {
        sign2 = sign1;
        index = ii;
        for (jj = 0; jj < y; ++jj)
        {
            leftMatrix(ii, jj, in, ret);
            // out->element[jj*y+ii] = sign2*detMatrix(ret);
            out->element[index] = sign2 * detMatrix(ret);
            sign2 = -sign2;
            index += y;
        }

        sign1 = -sign1;
    }
    DELETE_DYNAMIC_MATRIX(ret);
    return out;
}

DATA_TYPE invMatrix(struct easyMatrix *const in, 
                    struct easyMatrix *out)
{
    int i;
    if (in->cols != in->rows)
    {
        printf("ERROR:invMatrix cols and rows not equal!\n");
        return 0;
    };
    if (in->rows != out->cols || in->cols != out->rows)
    {
        printf("ERROR:input matrix and output matrix does not match!\n");
        return 0;
    };
    uint8 N = in->cols;
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, L, NULL);
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, LINV, NULL);
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, U, NULL);
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, UINV, NULL);
    getLUMatrix(in, L, U);
    invLMatrix(L, LINV);
    invUMatrix(U, UINV);
    multiMatrix(UINV, LINV, out);
    double s = 1;
    for (i = 0; i < N; i++)
        s *= U->element[i * N + i];
    /*
    adjMatrix(in,out);
    DATA_TYPE scale = detMatrix(in);
    if(scale<1e-5&&scale>-1e-5) return 0.0;
    scale = 1/scale;
    scaleMatrix(scale,out,out);
    */
    DELETE_DYNAMIC_MATRIX(L);
    DELETE_DYNAMIC_MATRIX(U);
    DELETE_DYNAMIC_MATRIX(LINV);
    DELETE_DYNAMIC_MATRIX(UINV);
    return isFiniteNumber(s);
}

struct easyMatrix *getLUMatrix(struct easyMatrix *const A,
                               struct easyMatrix *L,
                               struct easyMatrix *U)
{
    int i, j, k;
    int row = 0;
    DATA_TYPE s = 0;
    uint8 N = A->cols;
    int t = N * N;
    for (i = 0; i < t; i++)
    {
        L->element[i] = 1e-20;
        U->element[i] = 1e-20;
    }
    for (i = 0; i < N; i++)
    {
        L->element[i * N + i] = 1.0;
    }
    for (i = 0; i < N; i++)
    {
        for (j = i; j < N; j++)
        {
            s = 0.0;
            for (k = 0; k < i; ++k)
            {
                s += L->element[i * N + k] * U->element[k * N + j];
            }
            U->element[i * N + j] = A->element[i * N + j] - s;
        }
        for (j = i + 1; j < N; j++)
        {
            s = 0.0;
            for (k = 0; k < i; k++)
            {
                s += L->element[j * N + k] * U->element[k * N + i];
            }
            L->element[j * N + i] = (A->element[j * N + i] - s) / U->element[i * N + i]; 
        }
    }
    return L;
}

struct easyMatrix *invLMatrix(struct easyMatrix *const L,
                              struct easyMatrix *L_inv)
{
    int i;
    uint8 N = L->cols;
    if (N != L->rows)
    {
        printf("L matrix is not a sqare matrix!\n");
        return NULL;
    }
    DATA_TYPE s;
    int t = N * N;
    for (i = 0; i < t; i++)
    {
        L_inv->element[i] = 1e-13;
    }
    uint8 j, k;
    for (i = 0; i < N; i++)
    {
        L_inv->element[i * N + i] = 1;
    }
    for (i = 1; i < N; i++)
    {
        for (j = 0; j < i; j++)
        {
            s = 0;
            for (k = 0; k < i; k++)
            {
                s += L->element[i * N + k] * L_inv->element[k * N + j];
            }
            L_inv->element[i * N + j] = -s;
        }
    }
    return L_inv;
}
struct easyMatrix *invUMatrix(struct easyMatrix *const U,
                              struct easyMatrix *U_inv)
{
    int i;
    uint8 N = U->cols;
    DATA_TYPE s;
    int t = N * N;
    for (i = 0; i < t; i++)
    {
        U_inv->element[i] = 1e-13;
    }
    uint8 k;
    int j;
    for (i = 0; i < N; i++) 
    {
        U_inv->element[i * N + i] = 1 / U->element[i * N + i];
    }
    for (i = 1; i < N; i++)
    {
        for (j = i - 1; j >= 0; j--)
        {
            s = 0;
            for (k = j + 1; k <= i; k++)
            {
                s += U->element[j * N + k] * U_inv->element[k * N + i];
            }
            U_inv->element[j * N + i] = -s / U->element[j * N + j];
        }
    }
    return U_inv;
}
DATA_TYPE fastDetMatrix(struct easyMatrix *const in)
{
    int i;
    uint8 x = in->rows;
    uint8 y = in->cols;
    if (x != y)
        return 0;
    if (x == 0)
        return 0;
    if (x == 1)
        return in->element[0];
    DATA_TYPE *a = in->element;
    if (x == 2)
        return (a[0] * a[3] - a[1] * a[2]);
    int N = x;
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, L, NULL);
    CREATE_DYNAMIC_MATRIX_ONHEAP(N, N, U, NULL);
    getLUMatrix(in, L, U);
    double s = 1;
    for (i = 0; i < N; i++)
        s *= U->element[i * N + i];
    DELETE_DYNAMIC_MATRIX(L);
    DELETE_DYNAMIC_MATRIX(U);
    return s;
}

DATA_TYPE detMatrix(struct easyMatrix *const in)
{
    uint8 i;
    uint8 x = in->rows;
    uint8 y = in->cols;
    if (x != y)
    {
        printf("ERROR:Det Matrix input is not sqare matrix!");
        return 0;
    }
    if (x == 0)
    {
        printf("ERROR:Det Matrix input is zero!");
        return 0;
    }
    if (x == 1)
        return in->element[0];
    DATA_TYPE *a = in->element;
    if (x == 2)
        return (a[0] * a[3] - a[1] * a[2]);

    DATA_TYPE result = 0;
    signed char sign = 1;
    CREATE_DYNAMIC_MATRIX_ONHEAP(x - 1, y - 1, ret, NULL);
    for (i = 0; i < x; ++i)
    {
        leftMatrix(0, i, in, ret);
        result += sign * a[i] * detMatrix(ret);
        sign = -sign;
    }
    DELETE_DYNAMIC_MATRIX(ret);
    return result;
}

struct easyMatrix *addMatrix(const struct easyMatrix *const a, const struct easyMatrix *const b, struct easyMatrix *c)
{
    int i;
    if (a->cols != b->cols)
        return NULL;
    if (a->rows != b->rows)
        return NULL;
    struct easyMatrix *obj = (struct easyMatrix *)a;
    int t = obj->rows * obj->cols;
    for (i = 0; i < t; ++i)
    {
        c->element[i] = obj->element[i] + b->element[i];
    }
    return c;
}

struct easyMatrix *subMatrix(struct easyMatrix *const a,
                             struct easyMatrix *const b,
                             struct easyMatrix *c)
{
    int i;
    if (a->cols != b->cols)
        return NULL;
    if (a->rows != b->rows)
        return NULL;
    struct easyMatrix *obj = (struct easyMatrix *)a;
    int t = obj->rows * obj->cols;
    for (i = 0; i < t; ++i)
    {
        c->element[i] = obj->element[i] - b->element[i];
    }
    return c;
}

struct easyMatrix *scaleMatrix(DATA_TYPE scale, struct easyMatrix *const a, struct easyMatrix *b)
{
    int t = a->cols * a->rows;
    int i;
    for (i = 0; i < t; ++i)
    {
        b->element[i] = a->element[i] * scale;
    }
    return b;
}

struct easyMatrix *multiMatrix(struct easyMatrix *const a, 
                               struct easyMatrix *const b,
                               struct easyMatrix *c)
{
    uint8 i, j, k;
    if (NULL == c)
        return NULL;
    if (c == a || c == b)
        return NULL;
    if (a->cols != b->rows)
        return NULL;
    int count = 0;
    int t_cnt = 0;
    int z_cnt = 0;
    uint8 x = a->rows;
    uint8 y = a->cols;
    uint8 z = b->cols;
    for (i = 0; i < x; ++i)
    {
        for (k = 0; k < z; ++k)
        {
            c->element[count] = 0;
            z_cnt = 0;
            for (j = 0; j < y; ++j)
            {
                c->element[count] += a->element[t_cnt + j] * b->element[z_cnt + k];
                z_cnt += z;
            }
            count++;
        }
        t_cnt += y;
    }
    return c;
}

struct easyMatrix *zerosMatrix(struct easyMatrix *e)
{
    int i;
    int t = e->cols * e->rows;
    for (i = 0; i < t; ++i)
    {
        e->element[i] = 0;
    }
    return e;
}

struct easyMatrix *eyesMatrix(struct easyMatrix *e)
{
    uint8 i;
    if (e->rows != e->cols)
        return NULL;
    zerosMatrix(e);
    int index = 0;
    for (i = 0; i < e->rows; ++i)
    {
        e->element[index] = 1.0;
        index += (e->cols);
        ++index;
    }
    return e;
}
void dumpMatrix(struct easyMatrix *const e)
{
    uint8 i, j;
    int count = 0;
    int x = e->rows;
    int y = e->cols;
    printf("cols is:%d, rows is:%d\n", x, y);
    for (i = 0; i < x; ++i)
    {
        for (j = 0; j < y; ++j)
        {
            printf("%8f,", e->element[count]);
            ++count;
        }
        printf("\n");
    }
    return;
}
