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

for target in iipsrv.fcgi libopenjp2.so.2.3.1; do
   $DOCKER_TOOL run -v $TARGETS:/opt/mount --rm --entrypoint cp  $NAMESPACE/$INSTANCE /build/targets/$target /opt/mount/$target
done

