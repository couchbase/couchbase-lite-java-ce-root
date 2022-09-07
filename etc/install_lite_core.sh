#!/bin/sh
# Use this script to install the Couchbase Lite Core library necessary to build
# the Java/Kotlin language variants of the Couchbase Lite Platform.
#
# To use the script, run it from the root of a clone of the couchbase-lite-java-ce-root repository,
# supplying:
#   1) The ABI for the LiteCore library being installed.  Supported ABIs are:
#      linux/x86_64, macos/x86_64, windows/x86_64, android/arm64-v8a,
#      android/armeabi-v7a, android/x86, android/x86_64
#   2) The path to the root of a clone of the couchbase-lite-core repository
#   3) The path to the loadable LiteCore library.  Instructions for building the
#      LiteCore library can be found in its repository, https://github.com/couchbase/couchbase-lite-core


function usage() {
   echo "Usage: $0 <abi> <core root> <liteCore bin path>"
   exit 1
}

if [ ! -d "./common/common/main/java/com/couchbase/lite" ]; then
   echo "Run this script from the root of the cloned couchbase-lite-java-ce-root repository"
   exit 1
fi

if [ "$#" -ne 3 ]; then usage; fi

ABI="$1"
case $ABI in
   linux/x86_64 | macos/x86_64 | windows/x86_64 | android/arm64-v8a | android/armeabi-v7a | android/x86 | android/x86_64)
      ;;
   *)
      echo "The first argument to this script  must be and abi from:"
      echo "   linux/x86_64, macos/x86_64, windows/x86_64, android/arm64-v8a, android/armeabi-v7a, android/x86, android/x86_64"
      exit 1
      ;;
esac

CORE="$2"
if [ -z "${CORE}" ]; then usage; fi
if [ ! -d "${CORE}/C/include" ]; then
   echo "The second argument to this script must be the path to a clone of the couchbase-lite-core repository"
   exit 1
fi 

LIB="$3"
if [ -z "${LIB}" ]; then usage; fi
if [ ! -f "${LIB}" ]; then
   echo "The third argument to this script must be the path to the LiteCore library"
   exit 1
fi

mkdir -p "common/lite-core/${ABI}"/

mkdir "common/lite-core/${ABI}/include"
cp -a "${CORE}/C/include/"*.h "${CORE}/C/Cpp_include/"*.hh "${CORE}/vendor/fleece/API/fleece" "common/lite-core/${ABI}/include"

mkdir "common/lite-core/${ABI}/lib"
cp "${LIB}" "common/lite-core/${ABI}/lib"

