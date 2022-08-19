FROM public.ecr.aws/docker/library/centos:7

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
# we do this because something changed post April 8th that broke selecting full size tiles (e.g https://iiif-dev.internal.lib.virginia.edu/iiif/tsm:2830991/full/full/0/default.jpg)
RUN cd $APP_HOME/iipsrv && git checkout 1c0654f1bbaa6493ae0a36415290649f343e58c7

# do the code rewrite to force https id's
RUN mv $APP_HOME/iipsrv/src/IIIF.cc $APP_HOME/iipsrv/src/IIIF.cc.old && cat $APP_HOME/iipsrv/src/IIIF.cc.old | sed -e 's&"http://" : "https://"&"https://" : "https://"&g' > $APP_HOME/iipsrv/src/IIIF.cc

# and build
RUN cd $APP_HOME/iipsrv && ./autogen.sh && ./configure --with-kakadu=$APP_HOME/kakadu/v6_3_1-00379L && make clean && make all

# gather up final assets
RUN mkdir $APP_HOME/targets && cp $APP_HOME/kakadu/v6_3_1-00379L/lib/Linux-x86-64-gcc/libkdu_v63R.so $APP_HOME/targets && cp $APP_HOME/kakadu/v6_3_1-00379L/lib/Linux-x86-64-gcc/libkdu_a63R.so $APP_HOME/targets && cp $APP_HOME/iipsrv/src/iipsrv.fcgi $APP_HOME/targets

#
# end of file
#
