# running on a local dockerd
if [ -z "$DOCKER_HOST" ]; then
   DOCKER_TOOL=docker
else
   DOCKER_TOOL=docker-17.04.0
fi

# set the definitions
INSTANCE=iipsrv-builder
NAMESPACE=uvadave

TARGETS=/tmp/iipsvr.$$
mkdir -p $TARGETS > /dev/null 2>&1

for target in /build/targets/iipsrv.fcgi \
              /build/targets/libkdu_a63R.so \
              /build/targets/libkdu_v63R.so \
              /build/kakadu/v6_3_1-00379L/bin/Linux-x86-64-gcc/kdu_compress \
              /build/kakadu/v6_3_1-00379L/bin/Linux-x86-64-gcc/kdu_expand; do
   bn=$(basename $target)
   $DOCKER_TOOL run -v $TARGETS:/opt/mount --rm --entrypoint cp  $NAMESPACE/$INSTANCE $target /opt/mount/${bn}
done

echo "Targets available in $TARGETS on the docker host"
