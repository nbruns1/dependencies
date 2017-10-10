#!/bin/sh

if [ -z "$build" ] ; then
  echo '$build is undefined'
  exit 1
fi
if [ -z "$package_dir" ] ; then
  echo '$package_dir is undefined'
  exit 1
fi

package=cvc4
source="$package-$version.tar.gz"
build_dir=$build/$package-$version
url="http://cvc4.cs.stanford.edu/downloads/builds/src/$source"

if [ -z "$BOOST_ROOT" ]; then
  dependencies="libantlr3c-3.4 $DEPS_BOOST"
  boost_path="$root/$DEPS_BOOST"
else
  dependencies="libantlr3c-3.4"
  boost_path="$BOOST_ROOT"
fi

unpack() {
  cd $cache &&
  tar -xf $source &&
  mv -f $package-$version $build_dir
  cd $build_dir
}

build_install() {
  if [ -z "$target" ] ; then
    echo '$target is undefined'
  exit 1
  fi

  cd "$build_dir" &&
  # build CVC4 with --bsd to allow usage under the terms of
  # the modified BSD license.
  ./configure --prefix="$target" --bsd --with-antlr-dir=$root/libantlr3c-3.4 --with-boost=$boost_path &&
  make -j $num_threads &&
  make install &&
  cp -f "$package_dir/CVC4Config.cmake" "$target/CVC4Config.cmake"
}
