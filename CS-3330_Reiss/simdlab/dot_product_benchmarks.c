#include <stdlib.h>

#include <immintrin.h>

#include "dot_product.h"
/* reference implementation in C */
unsigned int dot_product_C(long size, unsigned short * a, unsigned short *b) {
    unsigned int sum = 0;
    for (int i = 0; i < size; ++i) {
        sum += a[i] * b[i];
    }
    return sum;
}

unsigned int vectorized_dot_product_C(long size, unsigned short * a, unsigned short *b) {
    // set to 0
    __m256i partialSum = _mm256_setzero_si256();
    __m256i partialSum1 = _mm256_setzero_si256();


    for(int i = 0; i < size; i += 16) {
        __m128i vecA = _mm_loadu_si128((__m128i*) &a[i]);
        __m256i vecAConverted = _mm256_cvtepu16_epi32(vecA);

        __m128i vecB = _mm_loadu_si128((__m128i*) &b[i]);
        __m256i vecBConverted = _mm256_cvtepu16_epi32(vecB);

        __m256i productOfAB = _mm256_mullo_epi32(vecAConverted, vecBConverted);
        partialSum = _mm256_add_epi32(partialSum, productOfAB);


        __m128i vecAa = _mm_loadu_si128((__m128i*) &a[i+8]);
        __m256i vecAaConverted = _mm256_cvtepu16_epi32(vecAa);

        __m128i vecBa = _mm_loadu_si128((__m128i*) &b[i+8]);
        __m256i vecBaConverted = _mm256_cvtepu16_epi32(vecBa);

        __m256i productOfABa = _mm256_mullo_epi32(vecAaConverted, vecBaConverted);
        partialSum1 = _mm256_add_epi32(partialSum1, productOfABa);
    }

    partialSum = _mm256_add_epi32(partialSum, partialSum1);

    unsigned int extractedPartialSum[8];
    _mm256_storeu_si256((__m256i*) &extractedPartialSum, partialSum);

    return extractedPartialSum[0] + extractedPartialSum[1] + extractedPartialSum[2] +
    extractedPartialSum[3] + extractedPartialSum[4] + extractedPartialSum[5] +
    extractedPartialSum[6] + extractedPartialSum[7];
}

// add prototypes here!
extern unsigned int dot_product_gcc7_O3(long size, unsigned short * a, unsigned short *b);

/* This is the list of functions to test */
function_info functions[] = {
    {dot_product_C, "C (local)"},
    {dot_product_gcc7_O3, "C (compiled with GCC7.2 -O3 -mavx2)"},
    {vectorized_dot_product_C, "vectorized dot product"},
    // add entries here!
    {NULL, NULL},
};
