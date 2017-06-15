#!/bin/sh

if [ -z "$build" ] ; then 
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then 
  echo '$package_dir is undefined'
  exit 1
fi
package=z3
version=4.5.0-x64-ubuntu-14.04
version2=4.5.0
source=$package-$version.zip
build_dir=$build/$package-$version
url=https://github.com/Z3Prover/z3/releases/download/$package-$version2/$source

unpack(){
  cd $cache &&
  message "unpacking $package" &&
  tar -xf $source &&
  message "finished unpacking $package" &&
  rm -rf $build_dir &&
  mv -f $cache/$package-$version $build_dir
}

pre_build() {
  cd $build_dir &&
  install_cmake_files $cmake_files_dir
}

build_install() {
  if [ -z "$target" ] ; then 
    echo '$target is undefined'
    exit 1
  fi
  cd $build_dir &&
  cmake_build_install
}

# vim: ts=2 sw=2 et
