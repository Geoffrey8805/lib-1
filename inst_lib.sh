#!/bin/bash
#

libfolder=$PWD
echo $libfolder

cpus=$(cat /proc/cpuinfo| grep "processor"| wc -l)
if [ -z $cpus ] || [ $cpus -lt 1 ]; then
	cpus=4
fi
echo "cpu=$cpus"

echo "https://github.com/google/flatbuffers.git"
git clone https://github.com/google/flatbuffers.git
[ -d flatbuffers/ ] && cd flatbuffers/ && \
	echo "cmake ." && cmake . && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/actor-framework/actor-framework.git"
git clone https://github.com/actor-framework/actor-framework.git
[ -d actor-framework/ ] && cd actor-framework/ && \
	echo "./configure --build-static --with-runtime-checks --no-examples --no-unit-tests --no-opencl --no-benchmarks --no-tools --no-python" && \
	./configure --build-static --with-runtime-checks --no-examples --no-unit-tests --no-opencl --no-benchmarks --no-tools --no-python && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/zeromq/libzmq.git"
git clone https://github.com/zeromq/libzmq.git
[ -d libzmq/ ] && cd libzmq/ && \
	echo "./autogen.sh" && ./autogen.sh && \
	echo "./configure --enable-static=yes --enable-valgrind" && \
	./configure --enable-static=yes --enable-valgrind && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/zeromq/azmq.git"
git clone https://github.com/zeromq/azmq.git
[ -d azmq/ ] && cd azmq/ && \
	echo "sudo cp -R azmq/ /usr/local/include/" && sudo cp -R azmq/ /usr/local/include/
cd $libfolder

echo "git clone https://github.com/zeromq/cppzmq.git"
git clone https://github.com/zeromq/cppzmq.git
[ -d cppzmq/ ] && cd cppzmq/ && \
	echo "sudo cp *.hpp /usr/local/include/" && sudo cp *.hpp /usr/local/include/
cd $libfolder

echo "git clone https://github.com/google/protobuf.git"
git clone https://github.com/google/protobuf.git
[ -d protobuf/ ] && cd protobuf/ && \
	echo "./autogen.sh" && ./autogen.sh && \
	echo "./configure --with-zlib" && ./configure --with-zlib && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/log4cplus/log4cplus.git -b 1.2.x"
git clone https://github.com/log4cplus/log4cplus.git -b 1.2.x
[ -d log4cplus/ ] && cd log4cplus/ && \
	echo "autoreconf -ivf" && autoreconf -ivf && \
	echo "CFLAGS+="-fPIC" CPPFLAGS+="-std=c++11 -fPIC" ./configure --enable-static=yes --enable-threads=yes" && CFLAGS+="-fPIC" CPPFLAGS+="-std=c++11 -fPIC" ./configure --enable-static=yes --enable-threads=yes && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/muflihun/easyloggingpp.git"
git clone https://github.com/muflihun/easyloggingpp.git
#cd $libfolder

echo "git clone https://github.com/paulftw/hiberlite.git"
git clone https://github.com/paulftw/hiberlite.git
[ -d hiberlite/ ] && cd hiberlite/ && \
	echo "git submodule init" && git submodule init && \
	echo "git submodule update" && git submodule update && \
	echo "make -j$cpus" && make -j$cpus && \
	echo "sudo cp -R include/ /usr/local/include/hiberlite/" && sudo cp -R include/ /usr/local/include/hiberlite/ && \
	echo "sudo cp lib*.a /usr/local/lib/" && sudo cp lib*.a /usr/local/lib/
cd $libfolder

echo "git clone https://github.com/nlohmann/json.git"
git clone https://github.com/nlohmann/json.git
[ -d json/ ] && cd json/src/ && \
	echo "sudo cp *.hpp /usr/local/include/" && sudo cp *.hpp /usr/local/include/
cd $libfolder

echo "git clone https://github.com/linux-can/can-utils.git"
git clone https://github.com/linux-can/can-utils.git
cd $libfolder
