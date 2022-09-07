
# Couchbase Lite Community Edition 2.0+

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**Couchbase Lite** is an embedded lightweight, document-oriented (NoSQL), syncable database engine.

Couchbase Lite 2.0+ has a completely new set of APIs. The implementation is on top of [Couchbase Lite Core](https://github.com/couchbase/couchbase-lite-core), which is also a new cross-platform implementation of database CRUD and query features, as well as document versioning.

This repo contains the code for the community editions of the Java-language family of products
for Couchbase Lite 2.0+.  This includes Java language products for the JVM, and Java and Kotlin language products for Android
Couchbase Lite 2.0+ is a completely new product, utterly divergent from the 1.0 version

## Issues

Please file any issues for either Java or Kotlin language products, here.  Be sure to specify which product and version you are using!

## Documentation

See: Developer Guide [Android](https://docs.couchbase.com/couchbase-lite/current/android/quickstart.html), [JVM](https://docs.couchbase.com/couchbase-lite/current/java/quickstart.html)

## Sample Apps

See:
* Learn Couchabase for [Android](https://developer.couchbase.com/android-kotlin-learning-key-value?learningPath=learn/android-kotlin-sync)
* Todo [Android](https://github.com/couchbaselabs/mobile-training-todo/tree/release/mercury/android), [Java Desktop](https://github.com/couchbaselabs/mobile-training-todo/tree/release/mercury/java-desktop), [Java Web Service](https://github.com/couchbaselabs/mobile-training-todo/tree/release/mercury/java-ws)

## Downloading

This project is a git repository with submodules.  To check it out, clone this root repository:

`git clone https://github.com/couchbase/couchbase-lite-java-ce-root --recurse-submodules`

or

`git clone https://github.com/couchbase/couchbase-lite-java-ce-root`
`git submodule update --init --recursive`

## Organization

There are two important top level directories:

* ce - This contains directories for product-specific code for each of the products, JVM and Java or Kotlin for Android
* common - This contains code that is used by the entire Java language product family

## Building

To build this product you will, first, have to clone https://github.com/couchbase/couchbase-lite-core and build
a LiteCore library appropriate for your application.  There are instructions in that repository that will
guide you through doing that.

Next you will have to install the LiteCore library in the directory <root>/common/lite-core.
You can use the shell script etc/install_lite_core.sh to do that

To build a product, navigate to the product home directory (ce/android, ce/android-ktx or ce/java) and follow the detailed insturctions there.
Note that building the Kotlin extensions depend on a CouchbaseLite Android library:  Use the gradle task publishToMavenLocal to
create a library that the Kotlin build can use.

The top level gradle build will build both products if everything is correctly configured.  At the very least, you will need:

* the appropriate LiteCore installed  in `./common/lite-core/<os>/<abi>/{lib,include}`
* local.properties files in both this the  product directories

## Using the Library

If you minify (Proguard) an application that uses CouchbaseLite you will need to add a few rules to your
Proguard configuration.  The rules are listed [here](https://docs.couchbase.com/couchbase-lite/2.7/java-android.html#ruleset)

## License

Apache 2 [license](LICENSE).

