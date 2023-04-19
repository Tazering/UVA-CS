#include <stdlib.h>
#include <limits.h>  /* for USHRT_MAX */

#include <immintrin.h>

#include "min.h"
/* reference implementation in C */
short min_C(long size, short * a) {
    short result = SHRT_MAX;
    for (int i = 0; i < size; ++i) {
        if (a[i] < result)
            result = a[i];
    }
    return result;
}

//student code
short vectorized_min_C(long size, short * a) {
    __m256i result = _mm256_set1_epi16(SHRT_MAX);

    //keep filtering until we get the smallest values
    for (int i = 0; i < size; i+=16) {
        __m256i current = _mm256_loadu_si256((__m256i*) &a[i]);
        result = _mm256_min_epi16(result, current);
    }

    short extractedResults[16];
    _mm256_storeu_si256((__m256i*) &extractedResults, result);
    short min = extractedResults[0];

    for(int i = 1; i < 16; i++) {
        if(min >= extractedResults[i]) {
            min = extractedResults[i];
        }
    }

    return min;
}


/* This is the list of functions to test */
function_info functions[] = {
    {min_C, "C (local)"},
    {vectorized_min_C, "C (vectorized)"},
    // add entries here!
    {NULL, NULL},
};
