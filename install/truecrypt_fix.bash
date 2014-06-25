#!/bin/bash

libs=( "/usr/local/lib/libmacfuse_i32.2.dylib" \
"/usr/local/lib/libosxfuse_i32.2.dylib" \
"/usr/local/lib/libosxfuse_i64.2.dylib" \
"/usr/local/lib/libmacfuse_i64.2.dylib" \
"/usr/local/lib/libosxfuse_i32.la" \
"/usr/local/lib/libosxfuse_i64.la" \
"/usr/local/lib/pkgconfig/osxfuse.pc" )

truecrypt="/Applications/TrueCrypt.app/Contents/Resources/Library"

for lib in "${libs[@]}"
do
  mv $lib "${truecrypt}/." && echo "Moved ${lib} to ${truecrypt}."
  rm $lib
  ln -s "${truecrypt}/$(basename $lib)" ${lib} && echo "Linked ${lib}."
done
