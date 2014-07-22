# Build Notes for Linux

## To understand a library linking

cd install/lib/
ldd librospack.so 
nm -a librospack.so 
nm -a librospack.so | grep Rospack

## Build catkin pkg manually

cd build/roseus
make
make VERBOSE=1
ls
less CMakeCache.txt 

