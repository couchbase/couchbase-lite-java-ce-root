# Working with Tombstones

The stack traces in tombstone files often do not appear very useful: many of the lines will have only the BuildId for the LiteCore that dumped and no references to code.  It may be possible to recover information from a tombstone, anyway.

## Useful tools

There are several tools that can be very helpful.

### file
`file` provides rudamentary information about the type of a file.  In particular, when working with tombstones, it can be used to identify ELF files, to tell whether their symbols have been stripped or not and to determine the `BuildId`

### nm
`nm` decodes symbols from an object file.  Of particular interest are the following flags:

* `-a`: display *all* symbols in the file (not just the external ones)
* `-C`: unmangle C++ symbols
* `-g`: show only external symbols
* `-l`: give file name and line number for symbol definition.

In particular, this phrase may be useful:

`nm -lC libLiteCore.so | grep couchbase-lite-core`

It may take several minutes to run but it will show line number of the definition for each of the (unmangled) symbols defined in a file that was compiled from a subdirectory of the directory `couchbase-lite-core*`.

### ndk-stack
`ndk-stack` is the the last step in the process: it will print the stack-trace complete with symbols and file names.

The tool will be in the top of the directory for each version of the ndk found in the Android SDK subdirectory "ndk".  I have not found significant differences between the tool versions in the various versions of the ndk.

The tool takes two arguments:

* `-sym`: the path to a directory that contains the unstripped libraries
* `-dump`: the path to the tombstone file with the stack trace 

```
$ANDROID_HOME/ndk/25.2.9519653/ndk-stack \
  -sym common/lite-core/android/arm64-v8a/lib \
  -dump bugreport-taimen-RP1A.201005.004.A1-2024-05-31-09-32-24/FS/data/tombstones/tombstone_03
```

## Analyzing a Tombstone

Analyzing a tombstone is very easy, once everything is set up: the above `ndk-stack` command is all you need.  It will provide a nice printout of the crash stack trace with unmangled symbols and the file and line number of the definition of each.

The hard part is getting things set up.

`ndk-stack` needs exactly the symbols for the library that generated the crash dump in order to do its magic with the tombstone file.  The standard place to find the symbols is an un-stripped version of the LiteCore that crashed.

In order to reduce the size of the binary, the LiteCore libraries, in release versions of the platform, are stripped: any symbol information not necessary for linking the library is removed.  The output of the `file` tool will confim this (libLiteCore.so, here was obtained from an exploded release .aar file):

```
file libLiteCore.so

libLiteCore.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=5a2f59a0c2d7ac3056f8b8f783b3ace25b38b0e8, stripped
```

You cannot simply use the LiteCore pulled from a release .aar because the symbols are gone.

Note that this is *not* true of debug builds.  Local builds of the Android platform are debug builds and are configured to copy the LiteCore library, verbatim, symbols and all, into the .aar.

### The Latestbuilds Repository

The LiteCore artifact repository on latestbuilds uses an undocumented and inconsistent naming convention, at least to the extent it predicts whether the library has symbols or not.

* `-symbols`: artifacts that contain this extension are dSym files.  They are not libraries, they are just symbol descriptions.  They exist only for MacOS and are useful for the debugger.
* `-debug`: artifacts named with this extension have been compiled with the debug flag which turns on debug level logging and other debugging instrumentation

It turns out that neither of these two flags is particularly relevant to whether the files contain symbols or not.

| Platform | release | debug |
| -------- | ------- | ------- |
| Android  | + | +  |
| iOS | *1 | *1  |
| Linux | - | - |
| MacOS | *1 | *1  |
| Windows | ? | ? |

    +: symbols included
    -: symbols not included
    ?: unknown
    *1: symbols not included in the library but available in the corresponding -symbols artifact


### Getting the Symbols

As is evident from the above table, both the debug and the release versions of the Android artifacts *have all symbols included*.  It is the Android platform build tools (the Android Gradle Plugin and the NDK) that strip the symbols from the LiteCore library.

Again, we can confirm the presence of symbols in the release version of an Android LiteCore library using the `file` tool.  Here is the output from using `file` on a release version of libLiteCore.so, downloaded from latestbuilds:

```
libLiteCore.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=5a2f59a0c2d7ac3056f8b8f783b3ace25b38b0e8, with debug_info, not stripped
```

When analyzing a tombstone from a CBSE, it is most likely that the stack trace was produced by a release build of LiteCore.  You should, therefore, use the release version from latestbuilds to provide symbols.

But which one?  To identify the correct LiteCore build, use the BuildId.  The tombstone stack trace will contain lines that look like this:

```
#00 pc 00000000003c7ba0  /data/app/~~8tUkxT8rEqtuO07q3dU5LA==/com.couchbase.lite.test-gLCTbJv_cqbTl-bSVIRBCg==/lib/arm64/libLiteCore.so (BuildId: df7e91a4a6188f4525b682f191e14e2fc0a3074c)
```

Even if they contain no other information, stack trace lines will include the `BuildId`.

As shown above the `file` tool can display the `BuildId` for a LiteCore library:

```
file libLiteCore.so

libLiteCore.so: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=5a2f59a0c2d7ac3056f8b8f783b3ace25b38b0e8, with debug_info, not stripped
```

Using any information that you have about the versions likely to have produced the crash -- likely machine architecture and so on -- download versions of LiteCore from latestbuilds and test them with `file` until you find the matching `BuildId`.  Now you are set up!

### Getting the Enhanced Stack Trace

To get the symbolic stack trace, for example, from  tombstone #3 from a bugreport generated by your Pixel 2XL (and assuming that you now have libLiteCore.so in your current directory):

```
$ANDROID_HOME/ndk/25.2.9519653/ndk-stack \
  -sym  .
  -dump bugreport-taimen-RP1A.201005.004.A1-2024-05-31-09-32-24/FS/data/tombstones/tombstone_03
```
