BASEDIR= ./
#THRIRDDIR=../../third
INC=-I$(BASEDIR) -I$(BASEDIR)/private/common

#LIB= -lpthread -levent -lssl -lcrypto #-lz -luuid -lcrypto
#BASELIB = 

SRC = $(wildcard $(BASEDIR)/*.cpp) $(wildcard $(BASEDIR)/private/common/*.cpp)

TARGET= libdugon.a


#CPPFLAGS+=-DGIT_SHA1="$(shell git log --format='\"sha1:%h author:%cn time:%ci commit:%s branch:%d\"' -1)"
FLAG=-g -Wno-deprecated -Wl,-rpath,../lib:./ -Wall -fPIC 
#-fdiagnostics-show-option  -fno-strict-aliasing -Wno-strict-aliasing -Wextra -Wformat -Wno-format-nonliteral -Wno-format-security -Wnon-virtual-dtor -Wctor-dtor-privacy -Wno-long-long  -Wno-redundant-decls -fPIC
#HEADERS = serverSession.h serverSessionMgr.h

OBJECT =  $(SRC:.cpp=.o)

.SUFFIXES: .o .c
.c.o:
	gcc -c  -g -Wall -D_GNU_SOURCE  -DOS_BITS_64 $(INC) -o $@ $<

.SUFFIXES: .o .cpp
.cpp.o:
	g++ -c $(FLAG) $(INC) -c -o $@ $<

all: $(TARGET)

$(TARGET): $(OBJECT)
	ar rcs  $@ $^

clean:
	rm $(EXELIB) $(OBJECT)  ./$(TARGET)
