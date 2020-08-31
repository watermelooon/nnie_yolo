CFLAGS += -I$(PWD)/src
CFLAGS += -I$(PWD)/third_party/hisi/include
CFLAGS += -L$(PWD)/third_party/hisi/lib

CXXFLAGS += -I$(PWD)/src
CXXFLAGS += -I$(PWD)/third_party/hisi/include
CXXFLAGS += -I$(PWD)/third_party/opencv3/include
CXXFLAGS += -L$(PWD)/third_party/opencv3/lib
CXXFLAGS += -L$(PWD)/third_party/hisi/lib

#LD_OPENCV_LIBS += -lopencv_highgui -lopencv_imgproc -lopencv_dnn -lopencv_ml -lopencv_photo \
#			-lopencv_objdetect -lopencv_stitching -lopencv_flann -lopencv_imgcodecs  -lopencv_core -lopencv_calib3d \
#		-lopencv_features2d
LD_OPENCV_LIBS += -lopencv_world

LD_HISI_LIBS +=  -lmpi -laacdec -laacenc -ldetail_ap \
-ldnvqe -ldpu_match -ldpu_rect -ldsp -lhdmi -lhdr_ap -lhi_cipher -lhiavslut -lhifisheyecalibrate \
-live -lmd -lmfnr_ap -lmpi_photo -lpciv\
-lpos_query -lsecurec -lsfnr_ap -lsvpruntime -ltde -lupvqe -lVoiceEngine -lnnie

CXXFLAGS += ${LD_OPENCV_LIBS}
CXXFLAGS += -std=c++11
CXXFLAGS += -Wno-error
CXXFLAGS += -fomit-frame-pointer -fstrict-aliasing -ffunction-sections -fdata-sections -ffast-math -fno-rtti -fno-exceptions -fpermissive
CXXFLAGS += -O3

SRCS := $(wildcard ./src/*.c)
TARGET := sample_nnie_main

# target source

OBJS  = $(SRCS:%.c=%.o)

CXX = aarch64-himix100-linux-g++
CC = aarch64-himix100-linux-gcc
.PHONY : clean all

dynamic:
	 $(CXX) -shared -fPIC -o libnnie_yolo.so ./sample/sample_nnie_main.cpp ./src/ins_nnie_interface.cpp ./src/sample_comm_svp.c   ./src/sample_comm_nnie.c ./src/nnie_core.c ${LD_HISI_LIBS}  $(CXXFLAGS)
static:
	aarch64-himix100-linux-ar rc libnnie_yolo.a ./sample/sample_nnie_main.o
all: $(TARGET)

$(TARGET):  ./sample/sample_nnie_main.o ./src/ins_nnie_interface.o $(OBJS) 
	$(CXX) $(CXXFLAGS)  -lpthread -lm -ldl -o $@ $^ -Wl,--start-group ${LD_HISI_LIBS} -Wl,--end-group

clean:
	@rm -f $(TARGET) ./sample/sample_nnie_main.o ./src/ins_nnie_interface.o ./src/util.o
	@rm -f $(OBJS)