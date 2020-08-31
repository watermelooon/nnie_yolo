#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <vector>
#include <sys/ioctl.h>
#include <dirent.h>
#include "ins_nnie_interface.h"
#include "Tensor.h"
#include "util.h"
#include "opencv2/highgui.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/core.hpp"
#include "opencv2/dnn.hpp"
#include <iostream>


int main()
{
  cv::Mat img = cv::imread("/root/nnie_yolo/knife.jpg",1);
  
  std::cout<<img.cols<<"  "<<img.rows<<std::endl;
  cv::imwrite("test.jpg",img);
  printf("save done");
  
}