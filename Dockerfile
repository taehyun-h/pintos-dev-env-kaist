From ubuntu:16.04

MAINTAINER Taehyun Hwang <taehyun9@kaist.ac.kr>

# 0. Ensure repo updated&gcc installed
RUN apt-get update

# 1. gcc-5.4&g++-5.4 install
WORKDIR /
RUN apt-get install -y gcc-5
RUN apt-get install -y g++-5

# make gcc-5.4&g++5.4 available
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 2

# 2. download bochs&pintos
RUN apt-get install -y wget
RUN wget https://jaist.dl.sourceforge.net/project/bochs/bochs/2.6.2/bochs-2.6.2.tar.gz
RUN wget http://cps.kaist.ac.kr/~byunggill/pintos.tar.gz
RUN tar xvf pintos.tar.gz
RUN rm pintos.tar.gz

# 3. install bochs

# dependency: ncurses
RUN apt-get install -y libncurses-dev
RUN apt-get install -y patch
RUN apt-get install -y xorg-dev
# build bochs and install
RUN env SRCDIR=/ PINTOSDIR=/pintos/ DSTDIR=/usr/local/ CC=gcc-5 CXX=g++-5 /pintos/src/misc/bochs-2.6.2-build.sh
RUN rm bochs-2.6.2.tar.gz

# 4. install qemu
RUN apt-get install -y qemu
RUN ln -s /usr/bin/qemu-system-x86_64 /usr/bin/qemu

# add pintos to PATH
ENV PATH $PATH:/pintos/src/utils

VOLUME [/pintos]
