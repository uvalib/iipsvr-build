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

for target in iipsrv.fcgi libkdu_a63R.so libkdu_v63R.so; do
   $DOCKER_TOOL run -v $TARGETS:/opt/mount --rm --entrypoint cp  $NAMESPACE/$INSTANCE /build/targets/$target /opt/mount/$target
done

echo "Targets available in $TARGETS on the docker host"
