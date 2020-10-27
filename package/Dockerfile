FROM centos:7

# dependancies
RUN yum -y update && yum -y install git libtool cmake gcc gcc-c++ libjpeg libjpeg-devel libtiff libtiff-devel

# create work directory
ENV APP_HOME /build
WORKDIR $APP_HOME

# install openjpeg
RUN git clone https://github.com/uclouvain/openjpeg.git

# move me later
RUN yum -y install make

# and build
RUN cd $APP_HOME/openjpeg && mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release && make

# some cleanup so the next steps work
RUN cp $APP_HOME/openjpeg/build/src/lib/openjp2/opj_config.h $APP_HOME/openjpeg/src/lib/openjp2/opj_config.h
RUN ln -s $APP_HOME/openjpeg/build/bin $APP_HOME/openjpeg/bin

# install iipsrv
RUN git clone https://github.com/ruven/iipsrv.git

# and build
RUN cd $APP_HOME/iipsrv && ./autogen.sh && ./configure --with-openjpeg=$APP_HOME/openjpeg && make clean && make all

# final assets
RUN mkdir $APP_HOME/targets && cp $APP_HOME/openjpeg/build/bin/libopenjp2.so.2.3.1 $APP_HOME/targets && cp $APP_HOME/iipsrv/src/iipsrv.fcgi $APP_HOME/targets
