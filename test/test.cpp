#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "test.h"


typedef unsigned char U_CHAR;


 /*
 Ä£ÐÍÀà±í
 0:µ¶¾ß
 1£º³éÑÌ
 2£º²ÍÅÌ
 3£º´©ÒÂ´÷Ã±-ÒÂ·þ
 4£º´©ÒÂ´÷Ã±-Ã±×Ó
 */

int main(int argc, char *argv[])
{
    const char *model_path_index = argv[1];
    const char *image_path = argv[2];
  	printf("build time:%s,%s\n",__DATE__,__TIME__);
  	int mindex=atoi(model_path_index);
    nnie_yolov3_init(mindex);
    unsigned int c=0;
    char *r;
   	float conf_threshold=0.6;
    while (1)
    {
        r = nnie_yolov3_detect(mindex, image_path, conf_threshold);
        if (r[9] > '5')
            printf("error!\n\n\n\n\n\n");
        printf("%s", r);
    }
    return 0;
}
