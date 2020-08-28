#!/bin/bash
#

libfolder=$PWD
echo $libfolder

cpus=$(cat /proc/cpuinfo | grep "processor" | wc -l)
if [ -z $cpus ] || [ $cpus -lt 1 ]; then
	cpus=4
fi
echo "cpu=$cpus"

function run_args() {
	folder=$PWD

	name=$1[@]
	args=("${!name}")

	for i in "${args[@]}"; do
		echo ${i}
		${i}
		ret=${?}
		echo ret=${ret}
		[ ${ret} -gt 0 ] && [ ${ret} -lt 128 ] && exit 1
	done

	cd $folder
}

function build() {
	name=$1[@]
	args=("${!name}")

	for i in "${args[@]}"; do
		echo ${i}
		run_args ${i}
	done
}

boost=(
	"wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz"
	"sleep 1"
	"tar xzvf boost_1_67_0.tar.gz"
	"cd boost_1_67_0"
	"./bootstrap.sh"
	"./b2 -j${cpus}"
	"sudo ./b2 -j${cpus} install"
)

gperftools=(
	"git clone https://github.com/gperftools/gperftools.git -b gperftools-2.5.93"
	"cd gperftools/"
	"./autogen.sh"
	"./configure"
	"make -j${cpus}"
	"sudo make install"
)

leveldb=(
	"git clone https://github.com/google/leveldb.git -b v1.20"
	"cd leveldb/"
	"make -j${cpus}"
	"sudo cp -R include/* /usr/local/include/"
	"sudo cp out-shared/lib* /usr/local/lib/"
	"sudo cp out-static/lib*.a /usr/local/lib/"
)

openssl=(
	"git clone https://github.com/openssl/openssl.git -b OpenSSL_1_0_2l"
	"cd openssl/"
	"./config shared --prefix=/usr/local/ssl --openssldir=/usr/local/ssl"
	"make -j${cpus}"
	"sudo make install"
)

flatbuffers=(
	"git clone https://github.com/google/flatbuffers.git -b v1.7.1"
	"cd flatbuffers/"
	"cmake ."
	"make -j${cpus}"
	"sudo make install"
)

caf=(
	"git clone https://github.com/actor-framework/actor-framework.git -b 0.17.6"
	"cd actor-framework/"
	"./configure --build-static"
	"cd build"
	"make -j${cpus}"
	"sudo make -j${cpus} install"
)

libzmq=(
	"git clone https://github.com/zeromq/libzmq.git -b v4.2.2"
	"cd libzmq/"
	"./autogen.sh"
	"./configure --enable-static=yes"
	"make -j${cpus}"
	"sudo make install"
)

azmq=(
	"git clone https://github.com/zeromq/azmq.git"
	"cd azmq/"
	"sudo cp -R azmq/ /usr/local/include/"
)

cppzmq=(
	"git clone https://github.com/zeromq/cppzmq.git"
	"cd cppzmq/"
	"sudo cp *.hpp /usr/local/include/"
)

protobuf=(
	"git clone https://github.com/google/protobuf.git -b v3.8.0"
	"cd protobuf/"
	"./autogen.sh"
	"./configure"
	"make -j${cpus}"
	"sudo make install"
)

log4cplus=(
	"git clone https://github.com/log4cplus/log4cplus.git -b REL_1_2_0"
	"cd log4cplus/"
	"autoreconf -ivf"
	"./configure --enable-static=yes --enable-threads=yes"
	"make -j${cpus} CFLAGS+=-fPIC CPPFLAGS+=-fPIC CPPFLAGS+=-std=c++11"
	"sudo make install"
)

easyloggingpp=(
	"git clone https://github.com/muflihun/easyloggingpp.git"
)

hiberlite=(
	"git clone https://github.com/paulftw/hiberlite.git"
	"cd hiberlite/"
	"git submodule init"
	"git submodule update"
	"make -j${cpus}"
	"sudo cp -R include/ /usr/local/include/hiberlite/"
	"sudo cp lib*.a /usr/local/lib/"
	"cd sqlite-amalgamation/"
	"sudo cp *.h /usr/local/include/"
)

json=(
	"git clone https://github.com/nlohmann/json.git"
	"cd json/src/"
	"sudo cp *.hpp /usr/local/include/"
)

can=(
	"git clone https://github.com/linux-can/can-utils.git"
)

WiringPi=(
	"git clone https://github.com/WiringPi/WiringPi.git"
)

mps=(
	"git clone https://github.com/Ravenbrook/mps.git -b release-1.115.0"
	"cd mps/"
	"./configure"
	"make -j${cpus}"
	"sudo make install"
)

jsoncpp=(
	"git clone https://github.com/open-source-parsers/jsoncpp.git"
	"cd jsoncpp/"
	"cmake ."
	"make -j${cpus}"
	"sudo make install"
)

mqttc=(
	"git clone https://github.com/eclipse/paho.mqtt.c.git -b v1.3.1"
	"cd paho.mqtt.c/"
	"cmake -DPAHO_BUILD_STATIC=YES ."
	"make -j${cpus}"
	"sudo make install"
)

mqttcpp=(
	"git clone https://github.com/eclipse/paho.mqtt.cpp.git -b v1.1"
	"cd paho.mqtt.cpp/"
	"cmake -Bbuild -H. -DPAHO_WITH_SSL=OFF -DPAHO_ENABLE_TESTING=OFF"
	"sudo cmake --build build/ --target install -j${cpus}"
	"sudo ldconfig"
)

glog=(
	"git clone https://github.com/google/glog.git -b v0.4.0"
	"cd glog"
	"./autogen.sh"
	"./configure"
	"make -j${cpus}"
	"sudo make install"
)

x264=(
	"git clone https://github.com/mirror/x264.git -b stable"
	"cd x264"
	"./configure --enable-static --enable-pic --disable-asm"
	"make -j${cpus}"
	"sudo make install"
)

ffmpeg=(
	"wget http://www.ffmpeg.org/releases/ffmpeg-3.4.6.tar.gz"
	"sleep 1"
	"tar xzvf ffmpeg-3.4.6.tar.gz"
	"cd ffmpeg-3.4.6"
	"./configure --enable-static --disable-shared --enable-gpl --enable-libx264 --enable-pic --disable-libxcb --disable-x86asm"
	"make -j${cpus}"
	"sudo make install"
)

jthread=(
	"git clone https://github.com/j0r1/JThread.git -b v1.3.1"
	"cd JThread"
	"cmake ."
	"make -j${cpus}"
	"sudo make install"
)

jrtp=(
	"git clone https://github.com/j0r1/JRTPLIB.git -b v3.11.2"
	"cd JRTPLIB"
	"cmake -DJRTPLIB_COMPILE_STATIC=YES ."
	"make -j${cpus}"
	"sudo make install"
)

echo args=$#
if [ $# -gt 0 ]; then
	for i in $@; do
		echo ${i}
		run_args ${i}
	done

	exit 0
fi

all_libs=(
	# "boost"
	# "gperftools"
	# "leveldb"
	# "openssl"
	# "flatbuffers"
	# "caf"
	# "libzmq"
	# "azmq"
	# "cppzmq"
	# "protobuf"
	# "log4cplus"
	# "jsoncpp"
	# "json"
	# "easyloggingpp"
	"mqttc"
	"glog"
	"x264"
	"ffmpeg"
	"jthread"
	"jrtp"
)
build all_libs
