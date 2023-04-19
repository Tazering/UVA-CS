#include <stdio.h>
#include <stdlib.h>
#include "defs.h"

/* 
 * Please fill in the following struct with your name and the name you'd like to appear on the scoreboard
 */
who_t who = {
    "Sp3ctre",           /* Scoreboard name */

    "Tyler Kim",   /* Full name */
    "tkj9ep@virginia.edu",  /* Email address */
};

/***************
 * ROTATE KERNEL
 ***************/

/******************************************************
 * Your different versions of the rotate kernel go here
 ******************************************************/

/* 
 * naive_rotate - The naive baseline version of rotate 
 */
char naive_rotate_descr[] = "naive_rotate: Naive baseline implementation";
void naive_rotate(int dim, pixel *src, pixel *dst) {
    for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
       	    dst[RIDX(dim-1-j, i, dim)] = src[RIDX(i, j, dim)];
        }
    }
	
}

//faster implementation with two unrolls
char rotateUnrollTwoDesc[] = "does loop unrolling for two values";
void rotateUnrollTwo(int dim, pixel *src, pixel *dst) {
    for(int i = 0; i < dim; i += 2) {
        for(int j = 0; j < dim; j++) {
            dst[RIDX(dim-1-j, i, dim)] = src[RIDX(i, j, dim)];
            dst[RIDX(dim-1-j, i+1, dim)] = src[RIDX(i + 1, j, dim)];
        }
    }
}

// four unrolls
char rotateUnrollFourDesc[] = "does loop unrolling for four values";
void rotateUnrollFour(int dim, pixel *src, pixel *dst) {
    for(int i = 0; i < dim; i += 4) {
        for(int j = 0; j < dim; j++) {
            dst[RIDX(dim-1-j, i, dim)] = src[RIDX(i, j, dim)];
            dst[RIDX(dim-1-j, i+1, dim)] = src[RIDX(i + 1, j, dim)];
            dst[RIDX(dim-1-j, i+2, dim)] = src[RIDX(i+2, j, dim)];
            dst[RIDX(dim-1-j, i+3, dim)] = src[RIDX(i + 3, j, dim)];

        }
    }
}

// unroll with access to dim as a variable
char rotateUnrollFourWithDimVariableDesc[] = "does loop unrolling for four values and sets dim as a variable";
void rotateUnrollFourWithDimVariable(int dim, pixel *src, pixel *dst) {
    int n = dim;
    for(int i = 0; i < n; i += 4) {
        for(int j = 0; j < n; j++) {
            dst[RIDX(n-1-j, i, n)] = src[RIDX(i, j, n)];
            dst[RIDX(n-1-j, i+1, n)] = src[RIDX(i + 1, j, n)];
            dst[RIDX(n-1-j, i+2, n)] = src[RIDX(i+2, j, n)];
            dst[RIDX(n-1-j, i+3, n)] = src[RIDX(i + 3, j, n)];

        }
    }
}

// unroll with access to dim as a variable
char rotateUnrollEightWithDimVariableDesc[] = "does loop unrolling for eight values and sets dim as a variable";
void rotateUnrollEightWithDimVariable(int dim, pixel *src, pixel *dst) {
    int n = dim;
    for(int i = 0; i < n; i += 8) {
        for(int j = 0; j < n; j++) {
            dst[RIDX(n-1-j, i, n)] = src[RIDX(i, j, n)];
            dst[RIDX(n-1-j, i+1, n)] = src[RIDX(i + 1, j, n)];
            dst[RIDX(n-1-j, i+2, n)] = src[RIDX(i+2, j, n)];
            dst[RIDX(n-1-j, i+3, n)] = src[RIDX(i + 3, j, n)];

            dst[RIDX(n-1-j, i+4, n)] = src[RIDX(i + 4, j, n)];
            dst[RIDX(n-1-j, i+5, n)] = src[RIDX(i + 5, j, n)];
            dst[RIDX(n-1-j, i+6, n)] = src[RIDX(i+6, j, n)];
            dst[RIDX(n-1-j, i+7, n)] = src[RIDX(i + 7, j, n)];

        }
    }
}

/* 
 * rotate - Your current working version of rotate
 *          Our supplied version simply calls naive_rotate
 */
char another_rotate_descr[] = "another_rotate: Another version of rotate";
void another_rotate(int dim, pixel *src, pixel *dst) 
{
    naive_rotate(dim, src, dst);
}

/*********************************************************************
 * register_rotate_functions - Register all of your different versions
 *     of the rotate function by calling the add_rotate_function() for
 *     each test function. When you run the benchmark program, it will
 *     test and report the performance of each registered test
 *     function.  
 *********************************************************************/

void register_rotate_functions() {
    add_rotate_function(&naive_rotate, naive_rotate_descr);
    add_rotate_function(&another_rotate, another_rotate_descr);
    add_rotate_function(&rotateUnrollTwo, rotateUnrollTwoDesc);
    add_rotate_function(&rotateUnrollFour, rotateUnrollFourDesc);
    add_rotate_function(&rotateUnrollFourWithDimVariable, rotateUnrollFourWithDimVariableDesc);
    add_rotate_function(&rotateUnrollEightWithDimVariable, rotateUnrollEightWithDimVariableDesc);
}
