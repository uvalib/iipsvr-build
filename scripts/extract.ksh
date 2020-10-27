#if [ -z "$DOCKER_HOST" ]; then
#   echo "ERROR: no DOCKER_HOST defined"
#   exit 1
#fi

# set the definitions
INSTANCE=iipsrv-builder
NAMESPACE=uvadave

for target in iipsrv.fcgi libopenjp2.so.2.3.1; do
   docker run -v $(PWD)/targets:/opt/mount --rm --entrypoint cp  $NAMESPACE/$INSTANCE /build/targets/$target /opt/mount/$target
done

