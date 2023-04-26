#include <stdio.h>
#include <stdlib.h>
#include "defs.h"
#include <immintrin.h>

/* 
 * Please fill in the following team struct 
 */
who_t who = {
    "Sp3ctre",           /* Scoreboard name */

    "Tyler Kim",      /* First member full name */
    "tkj9ep@virginia.edu",     /* First member email address */
};

/*** UTILITY FUNCTIONS ***/

/* You are free to use these utility functions, or write your own versions
 * of them. */

/* A struct used to compute averaged pixel value */
typedef struct {
    unsigned short red;
    unsigned short green;
    unsigned short blue;
    unsigned short alpha;
    unsigned short num;
} pixel_sum;

/* Compute min and max of two integers, respectively */
static int min(int a, int b) { return (a < b ? a : b); }
static int max(int a, int b) { return (a > b ? a : b); }

/* 
 * initialize_pixel_sum - Initializes all fields of sum to 0 
 */
static void initialize_pixel_sum(pixel_sum *sum) 
{
    sum->red = sum->green = sum->blue = sum->alpha = 0;
    sum->num = 0;
    return;
}

/* 
 * accumulate_sum - Accumulates field values of p in corresponding 
 * fields of sum 
 */
static void accumulate_sum(pixel_sum *sum, pixel p) 
{
    sum->red += (int) p.red;
    sum->green += (int) p.green;
    sum->blue += (int) p.blue;
    sum->alpha += (int) p.alpha;
    sum->num++;
    return;
}

/* 
 * assign_sum_to_pixel - Computes averaged pixel value in current_pixel 
 */
static void assign_sum_to_pixel(pixel *current_pixel, pixel_sum sum) 
{
    current_pixel->red = (unsigned short) (sum.red/sum.num);
    current_pixel->green = (unsigned short) (sum.green/sum.num);
    current_pixel->blue = (unsigned short) (sum.blue/sum.num);
    current_pixel->alpha = (unsigned short) (sum.alpha/sum.num);
    return;
}

/* 
 * avg - Returns averaged pixel value at (i,j) 
 */
static pixel avg(int dim, int i, int j, pixel *src) 
{
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
	for(int ii=max(i-1, 0); ii <= min(i+1, dim-1); ii++) 
	    accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

    assign_sum_to_pixel(&current_pixel, sum);
 
    return current_pixel;
}

//student code



/******************************************************
 * Your different versions of the smooth go here
 ******************************************************/

/* 
 * naive_smooth - The naive baseline version of smooth
 */
char naive_smooth_descr[] = "naive_smooth: Naive baseline implementation";
void naive_smooth(int dim, pixel *src, pixel *dst) 
{
    for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
            dst[RIDX(i,j, dim)] = avg(dim, i, j, src);
        }
    }
	
}
/* 
 * smooth - Your current working version of smooth
 *          Our supplied version simply calls naive_smooth
 */

// separate special cases
char specialCasesDesc[] = "separates out the special cases of the edges and corners";
void specialCases(int dim, pixel *src, pixel *dst) {

    //corner cases
    int corner[2] = {0, dim-1};

    for(int i = 0; i < 2; i++) {
        for(int j = 0; j < 2; j++) {
            int x = corner[i];
            int y = corner[j];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(y-1, 0); jj <= min(y+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x,y, dim)] = current_pixel;
            
        } 
    }


    //edge cases
    for(int i = 0; i < 2; i++) {
        for(int j = 1; j < dim - 1; j++) {
            int x = corner[i];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x, j, dim)] = current_pixel;


            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(jj,ii,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(j, x, dim)] = current_pixel;
 
    
        }
        
    }
    

    //middle of the image
    for(int i = 1; i < dim-1; i++) {
        for(int j = 1; j < dim-1; j++) {

            pixel_sum sum;
            pixel current_pixel;
            initialize_pixel_sum(&sum);

            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(i-1, 0); ii <= min(i+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(i, j, dim)] = current_pixel;
            
        }
    }


     
}




char specialCasesADesc[] = "special cases A; unroll corner";
void specialCasesA(int dim, pixel *src, pixel *dst) {

    //corner cases
    int corner[2] = {0, dim-1};

    //0,0
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, 0, dim)]); //0,0
    accumulate_sum(&sum, src[RIDX(0, 1, dim)]); //0,1
    accumulate_sum(&sum, src[RIDX(1, 0, dim)]); //1,0
    accumulate_sum(&sum, src[RIDX(1, 1, dim)]); //1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, 0, dim)] = current_pixel;

    //0, dim-1
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, dim-1, dim)]); //0, dim-1
    accumulate_sum(&sum, src[RIDX(0, dim-2, dim)]); //0, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-2, dim)]); //1, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-1, dim)]); //1, dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, dim-1, dim)] = current_pixel;


    //dim-1, 0
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, 0, dim)]); //dim-1,0
    accumulate_sum(&sum, src[RIDX(dim-2, 0, dim)]); //dim-2,0
    accumulate_sum(&sum, src[RIDX(dim-2, 1, dim)]); //dim-2,1
    accumulate_sum(&sum, src[RIDX(dim-1, 1, dim)]); //dim-1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, 0, dim)] = current_pixel;


    //dim-1,dim-1   
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, dim-1, dim)]); //dim-1,dim-1
    accumulate_sum(&sum, src[RIDX(dim-1, dim-2, dim)]); //dim-1,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-2, dim)]); //dim-2,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-1, dim)]); //dim-2,dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, dim-1, dim)] = current_pixel;


    //edge cases
    for(int i = 0; i < 2; i++) {
        for(int j = 1; j < dim - 1; j++) {
            int x = corner[i];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x, j, dim)] = current_pixel;


            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(jj,ii,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(j, x, dim)] = current_pixel;
 
    
        }
        
    }
    

    //middle of the image
    for(int i = 1; i < dim-1; i++) {
        for(int j = 1; j < dim-1; j++) {

            pixel_sum sum;
            pixel current_pixel;
            initialize_pixel_sum(&sum);

            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(i-1, 0); ii <= min(i+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(i, j, dim)] = current_pixel;
            
        }
    }
}


char specialCasesBDesc[] = "special cases B; unroll middle and corner";
void specialCasesB(int dim, pixel *src, pixel *dst) {

    //corner cases
    int corner[2] = {0, dim-1};

    //0,0
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, 0, dim)]); //0,0
    accumulate_sum(&sum, src[RIDX(0, 1, dim)]); //0,1
    accumulate_sum(&sum, src[RIDX(1, 0, dim)]); //1,0
    accumulate_sum(&sum, src[RIDX(1, 1, dim)]); //1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, 0, dim)] = current_pixel;

    //0, dim-1
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, dim-1, dim)]); //0, dim-1
    accumulate_sum(&sum, src[RIDX(0, dim-2, dim)]); //0, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-2, dim)]); //1, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-1, dim)]); //1, dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, dim-1, dim)] = current_pixel;


    //dim-1, 0
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, 0, dim)]); //dim-1,0
    accumulate_sum(&sum, src[RIDX(dim-2, 0, dim)]); //dim-2,0
    accumulate_sum(&sum, src[RIDX(dim-2, 1, dim)]); //dim-2,1
    accumulate_sum(&sum, src[RIDX(dim-1, 1, dim)]); //dim-1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, 0, dim)] = current_pixel;


    //dim-1,dim-1   
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, dim-1, dim)]); //dim-1,dim-1
    accumulate_sum(&sum, src[RIDX(dim-1, dim-2, dim)]); //dim-1,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-2, dim)]); //dim-2,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-1, dim)]); //dim-2,dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, dim-1, dim)] = current_pixel;


    //edge cases
    for(int i = 0; i < 2; i++) {
        for(int j = 1; j < dim - 1; j++) {
            int x = corner[i];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x, j, dim)] = current_pixel;


            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(jj,ii,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(j, x, dim)] = current_pixel;
 
    
        }
        
    }
    

    //middle of the image
    for(int i = 1; i < dim-1; i++) {
        for(int j = 1; j < dim-1; j++) {

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);

            accumulate_sum(&sum, src[RIDX(i-1, j-1, dim)]); //i-1,j-1
            accumulate_sum(&sum, src[RIDX(i-1, j, dim)]); //i-1, j
            accumulate_sum(&sum, src[RIDX(i-1, j+1, dim)]); //i-1, j+1
            accumulate_sum(&sum, src[RIDX(i, j-1, dim)]); //i, j-1
            accumulate_sum(&sum, src[RIDX(i, j, dim)]); //i,j
            accumulate_sum(&sum, src[RIDX(i, j+1, dim)]); //i, j+1
            accumulate_sum(&sum, src[RIDX(i+1, j-1, dim)]); //i+1, j-1
            accumulate_sum(&sum, src[RIDX(i+1, j, dim)]); //i+1, j
            accumulate_sum(&sum, src[RIDX(i+1, j+1, dim)]); //i+1, j+1

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(i, j, dim)] = current_pixel;

            
            
        }
    }
}



char vectorizationADesc[] = "vectorization version A";
void vectorizationA(int dim, pixel *src, pixel *dst) {

    //corner cases
    int corner[2] = {0, dim-1};

    //0,0
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, 0, dim)]); //0,0
    accumulate_sum(&sum, src[RIDX(0, 1, dim)]); //0,1
    accumulate_sum(&sum, src[RIDX(1, 0, dim)]); //1,0
    accumulate_sum(&sum, src[RIDX(1, 1, dim)]); //1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, 0, dim)] = current_pixel;

    //0, dim-1
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, dim-1, dim)]); //0, dim-1
    accumulate_sum(&sum, src[RIDX(0, dim-2, dim)]); //0, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-2, dim)]); //1, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-1, dim)]); //1, dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, dim-1, dim)] = current_pixel;


    //dim-1, 0
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, 0, dim)]); //dim-1,0
    accumulate_sum(&sum, src[RIDX(dim-2, 0, dim)]); //dim-2,0
    accumulate_sum(&sum, src[RIDX(dim-2, 1, dim)]); //dim-2,1
    accumulate_sum(&sum, src[RIDX(dim-1, 1, dim)]); //dim-1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, 0, dim)] = current_pixel;


    //dim-1,dim-1   
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, dim-1, dim)]); //dim-1,dim-1
    accumulate_sum(&sum, src[RIDX(dim-1, dim-2, dim)]); //dim-1,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-2, dim)]); //dim-2,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-1, dim)]); //dim-2,dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, dim-1, dim)] = current_pixel;


    //edge cases
    for(int i = 0; i < 2; i++) {
        for(int j = 1; j < dim - 1; j++) {
            int x = corner[i];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x, j, dim)] = current_pixel;


            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(jj,ii,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(j, x, dim)] = current_pixel;
 
    
        }
        
    }
    

    //middle of the image
    for(int i = 1; i < dim-1; i++) {
        for(int j = 1; j < dim-1; j++) {

            //i-1, j-1
            __m128i theTLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j-1, dim)]);
            __m256i theTLPixelConverted = _mm256_cvtepu8_epi16(theTLPixel);

            //i-1, j
            __m128i theTPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j, dim)]);
            __m256i theTPixelConverted = _mm256_cvtepu8_epi16(theTPixel);

            //i-1, j+1
            __m128i theTRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j+1, dim)]);
            __m256i theTRPixelConverted = _mm256_cvtepu8_epi16(theTRPixel);

            //i, j-1
            __m128i theLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j-1, dim)]);
            __m256i theLPixelConverted = _mm256_cvtepu8_epi16(theLPixel);

            //i, j
            __m128i theCPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j, dim)]);
            __m256i theCPixelConverted = _mm256_cvtepu8_epi16(theCPixel);

            //i, j+1
            __m128i theRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j+1, dim)]);
            __m256i theRPixelConverted = _mm256_cvtepu8_epi16(theRPixel);

            //i+1, j-1
            __m128i theBLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j-1, dim)]);
            __m256i theBLPixelConverted = _mm256_cvtepu8_epi16(theBLPixel);

            //i+1, j
            __m128i theBPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j, dim)]);
            __m256i theBPixelConverted = _mm256_cvtepu8_epi16(theBPixel);

            //i+1, j+1
            __m128i theBRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j+1, dim)]);
            __m256i theBRPixelConverted = _mm256_cvtepu8_epi16(theBRPixel);

            //accumulate
            __m256i partialSum1 = _mm256_add_epi16(theTLPixelConverted, theTPixelConverted);
            partialSum1 = _mm256_add_epi16(partialSum1, theTRPixelConverted);

            __m256i partialSum2 = _mm256_add_epi16(theLPixelConverted, theCPixelConverted);
            partialSum2 = _mm256_add_epi16(partialSum2, theRPixelConverted);

            __m256i partialSum3 = _mm256_add_epi16(theBLPixelConverted, theBPixelConverted);
            partialSum3 = _mm256_add_epi16(partialSum3, theBRPixelConverted);

            //sum
            __m256i sumOfPixels = _mm256_add_epi16(partialSum1, partialSum2);
            sumOfPixels = _mm256_add_epi16(sumOfPixels, partialSum3);

            unsigned short pixelElements[16];
            _mm256_storeu_si256((__m256i*) pixelElements, sumOfPixels);

            // assign_sum_to_pixel(&current_pixel, sum);
            pixel current_pixel;
            current_pixel.red = pixelElements[0]/9;
            current_pixel.blue = pixelElements[2]/9;
            current_pixel.green = pixelElements[1]/9;
            current_pixel.alpha = pixelElements[3]/9;

            dst[RIDX(i, j, dim)] = current_pixel;

            
            
        }
    }
}


char vectorizationBDesc[] = "vectorization version B with 4b";
void vectorizationB(int dim, pixel *src, pixel *dst) {

    //corner cases
    int corner[2] = {0, dim-1};

    //0,0
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, 0, dim)]); //0,0
    accumulate_sum(&sum, src[RIDX(0, 1, dim)]); //0,1
    accumulate_sum(&sum, src[RIDX(1, 0, dim)]); //1,0
    accumulate_sum(&sum, src[RIDX(1, 1, dim)]); //1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, 0, dim)] = current_pixel;

    //0, dim-1
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(0, dim-1, dim)]); //0, dim-1
    accumulate_sum(&sum, src[RIDX(0, dim-2, dim)]); //0, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-2, dim)]); //1, dim-2
    accumulate_sum(&sum, src[RIDX(1, dim-1, dim)]); //1, dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(0, dim-1, dim)] = current_pixel;


    //dim-1, 0
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, 0, dim)]); //dim-1,0
    accumulate_sum(&sum, src[RIDX(dim-2, 0, dim)]); //dim-2,0
    accumulate_sum(&sum, src[RIDX(dim-2, 1, dim)]); //dim-2,1
    accumulate_sum(&sum, src[RIDX(dim-1, 1, dim)]); //dim-1,1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, 0, dim)] = current_pixel;


    //dim-1,dim-1   
    initialize_pixel_sum(&sum);
    accumulate_sum(&sum, src[RIDX(dim-1, dim-1, dim)]); //dim-1,dim-1
    accumulate_sum(&sum, src[RIDX(dim-1, dim-2, dim)]); //dim-1,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-2, dim)]); //dim-2,dim-2
    accumulate_sum(&sum, src[RIDX(dim-2, dim-1, dim)]); //dim-2,dim-1
    assign_sum_to_pixel(&current_pixel, sum);
    dst[RIDX(dim-1, dim-1, dim)] = current_pixel;


    //edge cases
    for(int i = 0; i < 2; i++) {
        for(int j = 1; j < dim - 1; j++) {
            int x = corner[i];

            pixel_sum sum;
            pixel current_pixel;

            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(x, j, dim)] = current_pixel;


            initialize_pixel_sum(&sum);
            for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
            for(int ii=max(x-1, 0); ii <= min(x+1, dim-1); ii++) 
                accumulate_sum(&sum, src[RIDX(jj,ii,dim)]);

            assign_sum_to_pixel(&current_pixel, sum);
            dst[RIDX(j, x, dim)] = current_pixel;
 
    
        }
        
    }
    

    //middle of the image
    for(int i = 1; i < dim-1; i++) {
        for(int j = 1; j < dim-1; j++) {

            //i-1, j-1
            __m128i theTLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j-1, dim)]);
            __m256i theTLPixelConverted = _mm256_cvtepu8_epi16(theTLPixel);

            //i-1, j
            __m128i theTPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j, dim)]);
            __m256i theTPixelConverted = _mm256_cvtepu8_epi16(theTPixel);

            //i-1, j+1
            __m128i theTRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i-1, j+1, dim)]);
            __m256i theTRPixelConverted = _mm256_cvtepu8_epi16(theTRPixel);

            //i, j-1
            __m128i theLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j-1, dim)]);
            __m256i theLPixelConverted = _mm256_cvtepu8_epi16(theLPixel);

            //i, j
            __m128i theCPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j, dim)]);
            __m256i theCPixelConverted = _mm256_cvtepu8_epi16(theCPixel);

            //i, j+1
            __m128i theRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i, j+1, dim)]);
            __m256i theRPixelConverted = _mm256_cvtepu8_epi16(theRPixel);

            //i+1, j-1
            __m128i theBLPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j-1, dim)]);
            __m256i theBLPixelConverted = _mm256_cvtepu8_epi16(theBLPixel);

            //i+1, j
            __m128i theBPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j, dim)]);
            __m256i theBPixelConverted = _mm256_cvtepu8_epi16(theBPixel);

            //i+1, j+1
            __m128i theBRPixel = _mm_loadu_si128((__m128i*) &src[RIDX(i+1, j+1, dim)]);
            __m256i theBRPixelConverted = _mm256_cvtepu8_epi16(theBRPixel);

            //accumulate
            __m256i partialSum1 = _mm256_add_epi16(theTLPixelConverted, theTPixelConverted);
            partialSum1 = _mm256_add_epi16(partialSum1, theTRPixelConverted);

            __m256i partialSum2 = _mm256_add_epi16(theLPixelConverted, theCPixelConverted);
            partialSum2 = _mm256_add_epi16(partialSum2, theRPixelConverted);

            __m256i partialSum3 = _mm256_add_epi16(theBLPixelConverted, theBPixelConverted);
            partialSum3 = _mm256_add_epi16(partialSum3, theBRPixelConverted);

            //sum
            __m256i sumOfPixels = _mm256_add_epi16(partialSum1, partialSum2);
            sumOfPixels = _mm256_add_epi16(sumOfPixels, partialSum3);

            unsigned short pixelElements[16];
            _mm256_storeu_si256((__m256i*) pixelElements, sumOfPixels);

            // assign_sum_to_pixel(&current_pixel, sum);
            pixel current_pixel;
            current_pixel.red = (pixelElements[0] * 7282) >> 16;
            current_pixel.blue = (pixelElements[2] * 7282) >> 16;
            current_pixel.green = (pixelElements[1] * 7282) >> 16;
            current_pixel.alpha = (pixelElements[3] * 7282) >> 16;

            dst[RIDX(i, j, dim)] = current_pixel;

            
            
        }
    }
}

/*********************************************************************
 * register_smooth_functions - Register all of your different versions
 *     of the smooth function by calling the add_smooth_function() for
 *     each test function. When you run the benchmark program, it will
 *     test and report the performance of each registered test
 *     function.  
 *********************************************************************/

void register_smooth_functions() {
    add_smooth_function(&naive_smooth, naive_smooth_descr);
    add_smooth_function(&specialCases, specialCasesDesc);
    add_smooth_function(&specialCasesA, specialCasesADesc);
    add_smooth_function(&specialCasesB, specialCasesBDesc);
    add_smooth_function(&vectorizationA, vectorizationADesc);
    add_smooth_function(&vectorizationB, vectorizationBDesc)

}
