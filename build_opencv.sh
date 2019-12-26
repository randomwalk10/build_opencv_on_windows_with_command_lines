#!/bin/bash -e
myRepo=$(pwd)
CMAKE_CONFIG_GENERATOR="Visual Studio 14 2015 Win64"
opencv_version="4.1.2"
opencv_name="opencv-$opencv_version"
if [  ! -d "$myRepo/$opencv_name"  ]; then
    echo "cloning opencv"
    mkdir "$opencv_name"
    git clone "https://github.com/opencv/opencv.git" --branch="$opencv_version" "./$opencv_name"
else
    echo "opencv already downloaded"
fi

opencv_contrib_name="opencv_contrib-$opencv_version"
if [  ! -d "$myRepo/$opencv_contrib_name"  ]; then
    echo "cloning opencv_contrib"
    mkdir "$opencv_contrib_name"
    git clone "https://github.com/opencv/opencv_contrib.git" --branch="$opencv_version" "./$opencv_contrib_name"
else
    echo "opencv_contrib already downloaded"
fi

mkdir -p build
rm -rf build/"$opencv_name"
mkdir -p build/"$opencv_name"
mkdir -p install
rm -rf install/"$opencv_name"
mkdir -p install/"$opencv_name"
pushd build/"$opencv_name"
CMAKE_OPTIONS='-D CUDA_ARCH_BIN=7.5 -DBUILD_SHARED_LIBS:BOOL=OFF -DPYTHON_DEFAULT_EXECUTABLE=C:\Python27\python.ext -DBUILD_opencv_python:BOOL=OFF -D BUILD_opencv_python2=OFF -D INSTALL_C_EXAMPLES=OFF -D WITH_JPEG=ON -D BUILD_JPEG=ON -D WITH_PNG=ON -D BUILD_PNG=ON -D WITH_TIFF=ON -D BUILD_TIFF=ON -D WITH_JASPER=ON -D BUILD_JASPER=ON -D WITH_ZLIB=ON -D BUILD_ZLIB=ON -D BUILD_EXAMPLES=OFF -D WITH_TBB=ON -D BUILD_TBB=OFF -D WITH_IPP=ON -D BUILD_IPP_IW=ON -D ENABLE_PRECOMPILED_HEADERS=OFF -D WITH_OPENCL=OFF -D ENABLE_CXX11=ON -DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DBUILD_DOCS:BOOL=OFF -D WITH_CUDA=ON -D ENABLE_FAST_MATH=ON -D CUDA_FAST_MATH=ON -D WITH_CUBLAS=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.1.2/modules -DBUILD_EXAMPLES:BOOL=OFF -DINSTALL_CREATE_DISTRIB=OFF'
cmake -G"$CMAKE_CONFIG_GENERATOR" $CMAKE_OPTIONS -D CMAKE_INSTALL_PREFIX="$myRepo"/install/"$opencv_name" "$myRepo/$opencv_name"
echo "************************* $Source_DIR -->debug"
cmake --build .  --config debug
echo "************************* $Source_DIR -->release"
cmake --build .  --config release
cmake --build .  --target install --config release
cmake --build .  --target install --config debug
popd
