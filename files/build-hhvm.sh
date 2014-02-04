cd /usr/local/src/hiphop-php
export CMAKE_PREFIX_PATH=`pwd`
cd /usr/local/src/hiphop-php/hhvm
git submodule init
  
# compile libevent
cd /usr/local/src/hiphop-php/libevent
cat ../hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1
./autogen.sh
./configure --prefix=/usr/local/src/hiphop-php
make
make install
cd ..
  
# build hiphop
cd hhvm
git submodule update
export HPHP_HOME=`pwd`
cmake .
make