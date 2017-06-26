#!/bin/bash
#

libfolder=$PWD
echo $libfolder

cpus=$(cat /proc/cpuinfo| grep "processor"| wc -l)
if [ -z $cpus ] || [ $cpus -lt 1 ]; then
	cpus=4
fi
echo "cpu=$cpus"

echo "git clone https://github.com/gperftools/gperftools.git -b gperftools-2.5.93"
git clone https://github.com/gperftools/gperftools.git -b gperftools-2.5.93
[ -d gperftools/ ] && cd gperftools/ && \
	echo "./autogen.sh" && ./autogen.sh && \
	echo "./configure" && ./configure && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

#echo "git clone https://github.com/Ravenbrook/mps.git -b release-1.115.0"
#git clone https://github.com/Ravenbrook/mps.git -b release-1.115.0
#[ -d mps/ ] && cd mps/ && \
#	echo "./configure" && ./configure && \
#	echo "make -j$cpus" && make -j$cpus && sudo make install
#cd $libfolder

echo "git clone https://github.com/google/leveldb.git -b v1.20"
git clone https://github.com/google/leveldb.git -b v1.20
[ -d leveldb/ ] && cd leveldb/ && \
	echo "make -j$cpus" && make -j$cpus && \
	sudo cp -R include/* /usr/local/include/ && \
	sudo cp out-shared/lib* /usr/local/lib/ && \
	sudo cp out-static/lib*.a /usr/local/lib/
cd $libfolder

echo "git clone https://github.com/openssl/openssl.git -b OpenSSL_1_0_2l"
git clone https://github.com/openssl/openssl.git -b OpenSSL_1_0_2l
[ -d openssl/ ] && cd openssl/ && \
	echo "./config  --prefix=/usr/local --openssldir=/usr/local/ssl" && \
	./config shared --prefix=/usr/local --openssldir=/usr/local/ssl && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/google/flatbuffers.git -b v1.7.1"
git clone https://github.com/google/flatbuffers.git -b v1.7.1
[ -d flatbuffers/ ] && cd flatbuffers/ && \
	echo "cmake ." && cmake . && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/actor-framework/actor-framework.git -b 0.15.3"
git clone https://github.com/actor-framework/actor-framework.git -b 0.15.3
[ -d actor-framework/ ] && cd actor-framework/ && \
	echo "./configure --build-static --with-runtime-checks --no-examples --no-unit-tests --no-opencl --no-benchmarks --no-tools --no-python" && \
	./configure --build-static --with-runtime-checks --no-examples --no-unit-tests --no-opencl --no-benchmarks --no-tools --no-python && \
	echo "make" && make && sudo make install
cd $libfolder

echo "git clone https://github.com/zeromq/libzmq.git -b v4.2.2"
git clone https://github.com/zeromq/libzmq.git -b v4.2.2
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

echo "git clone https://github.com/google/protobuf.git -b v3.3.2"
git clone https://github.com/google/protobuf.git -b v3.3.2
[ -d protobuf/ ] && cd protobuf/ && \
	echo "./autogen.sh" && ./autogen.sh && \
	echo "./configure --with-zlib" && ./configure --with-zlib && \
	echo "make -j$cpus" && make -j$cpus && sudo make install
cd $libfolder

echo "git clone https://github.com/log4cplus/log4cplus.git -b REL_1_2_0"
git clone https://github.com/log4cplus/log4cplus.git -b REL_1_2_0
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

echo "git clone https://github.com/WiringPi/WiringPi.git"
git clone https://github.com/WiringPi/WiringPi.git
cd $libfolder
