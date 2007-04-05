
#!/bin/bash

# run as ./scripts/check-public-version.sh

# default version to test - override by passing in an argument
ver="2.1.4"

if [ ! "k$1" = "k" ]; then
    ver="$1"
fi

echo "Working in /tmp/yarpy -- delete directory to start fresh"
cd /tmp
#rm -rf yarpy
mkdir -p yarpy
cd yarpy

BASE=$PWD
echo "" > report.txt

if [ ! -e yarp-$ver.tar.gz ] ; then
    wget http://eris.liralab.it/yarp/downloads/yarp/yarp-$ver.tar.gz
    rm -rf tgz-automake
    rm -rf tgz-cmake
fi

if [ ! -e yarp-$ver.zip ] ; then
    wget http://eris.liralab.it/yarp/downloads/yarp/yarp-$ver.zip
    rm -rf zip-cmake
fi

cd $BASE
if [ ! -e tgz-automake ] ; then
    mkdir -p tgz-automake
    cd tgz-automake
    tar xzvf - < ../yarp-$ver.tar.gz
fi

cd $BASE
if [ -e tgz-automake ] ; then
    cd tgz-automake
    cd yarp-*
    if [ ! -e configure ]; then
	./bootstrap.sh || exit 1
    fi
    if [ ! -e Makefile ]; then
	./configure || exit 1
    fi
    make && ( echo "automake is good" >> $BASE/report.txt )
fi

cd $BASE
if [ ! -e tgz-cmake ] ; then
    mkdir -p tgz-cmake
    cd tgz-cmake
    tar xzvf - < ../yarp-$ver.tar.gz
fi

cd $BASE
if [ -e tgz-cmake ] ; then
    cd tgz-cmake
    cd yarp-*
    if [ ! -e CMakeCache.txt ]; then
	cmake . || exit 1
    fi
    make && ( echo "tgz cmake is good" >> $BASE/report.txt )
fi


cd $BASE
if [ ! -e zip-cmake ] ; then
    mkdir -p zip-cmake
    cd zip-cmake
    unzip ../yarp-$ver.zip
fi

cd $BASE
if [ -e zip-cmake ] ; then
    cd zip-cmake
    cd yarp-*
    if [ ! -e CMakeCache.txt ]; then
	cmake . || exit 1
    fi
    make && ( echo "zip cmake is good" >> $BASE/report.txt )
fi

cat $BASE/report.txt
