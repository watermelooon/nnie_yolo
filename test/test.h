extern "C"
{
int  nnie_yolov3_init(int class_type);
char * nnie_yolov3_detect(int class_type,const char *image_path,float conf_threshold);
} 