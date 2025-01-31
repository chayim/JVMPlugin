if [ -z ${OS+x} ]
then
      echo "os is not set"
      exit 1
fi

if [ -z ${ARCH+x} ]
then
      echo "arch is not set"
      exit 1
fi

if [ -z ${DIST+x} ]
then
      echo "dist is not set"
      exit 1
fi

if [ -z ${DIST_VERSION+x} ]
then
      echo "dist_version is not set"
      exit 1
fi

echo "installing redisgears for :" $OS

WORK_DIR=./bin/RedisGears/
REDISGEARS_ZIP=redisgears.$OS-$DIST$DIST_VERSION-$ARCH.master.zip
REDISGEARS_DEPS=redisgears-python.$OS-$DIST$DIST_VERSION-$ARCH.master.tgz
REDISGEARS_S3_PATH=http://redismodules.s3.amazonaws.com/redisgears/snapshots/$REDISGEARS_ZIP
REDISGEARS_DEPS_S3_PATH=http://redismodules.s3.amazonaws.com/redisgears/snapshots/$REDISGEARS_DEPS

mkdir -p $WORK_DIR

if [ -f "$WORK_DIR$REDISGEARS_ZIP" ]; then
    echo "Skiping RedisGears download"
else 
    echo "Download RedisGears"
    wget -P $WORK_DIR $REDISGEARS_S3_PATH
    unzip $WORK_DIR$REDISGEARS_ZIP -d $WORK_DIR
fi

if [ -f "$WORK_DIR$REDISGEARS_DEPS" ]; then
    echo "Skiping RedisGears download"
else 
    echo "Download RedisGears deps"
    wget -P $WORK_DIR $REDISGEARS_DEPS_S3_PATH
    tar -C $WORK_DIR -xvf $WORK_DIR$REDISGEARS_DEPS
fi