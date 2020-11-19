FROM centos:7

# dependancies
RUN yum -y update && yum -y install git libtool cmake gcc gcc-c++ libjpeg libjpeg-devel libtiff libtiff-devel make

# create work directory
ENV APP_HOME /build
WORKDIR $APP_HOME

# install the kakdu libraries
RUN mkdir -p $APP_HOME/kakadu/v6_3_1-00379L
COPY kakadu/v6_3_1-00379L/ $APP_HOME/kakadu/v6_3_1-00379L/

# and build (ignore errors)
RUN cd $APP_HOME/kakadu/v6_3_1-00379L/make && make -f Makefile-Linux-x86-64-gcc; exit 0

# install iipsrv
RUN git clone https://github.com/ruven/iipsrv.git

# and build
RUN cd $APP_HOME/iipsrv && ./autogen.sh && ./configure --with-kakadu=$APP_HOME/kakadu/v6_3_1-00379L && make clean && make all

# gather up final assets
RUN mkdir $APP_HOME/targets && cp $APP_HOME/kakadu/v6_3_1-00379L/lib/Linux-x86-64-gcc/libkdu_v63R.so $APP_HOME/targets && cp $APP_HOME/kakadu/v6_3_1-00379L/lib/Linux-x86-64-gcc/libkdu_a63R.so $APP_HOME/targets && cp $APP_HOME/iipsrv/src/iipsrv.fcgi $APP_HOME/targets

#
# end of file
#
