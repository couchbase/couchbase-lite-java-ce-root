
# Couchbase Lite Community Edition 2.0

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**Couchbase Lite** is an embedded lightweight, document-oriented (NoSQL), syncable database engine.

Couchbase Lite 2.0 has a completely new set of APIs. The implementation is on top of [Couchbase Lite Core](https://github.com/couchbase/couchbase-lite-core), which is also a new cross-platform implementation of database CRUD and query features, as well as document versioning.

This repo contains the code for the community editions of the Java-language family of products
for Couchbase Lite 2.0.  This includs the Java AppServer and Android products.
Couchbase Lite 2.0 is a completely new product, utterly divergent from the 1.0 version

## Issues

Please file any issues for either the Java AppServer or the Android product, here.  Be sure to specify which you are using!

## Documentation

See: [Developer Guide](https://developer.couchbase.com/documentation/mobile/2.0/couchbase-lite/java.html)

## Sample Apps

See: [Todo](https://github.com/couchbaselabs/mobile-training-todo/tree/feature/2.0)

## Downloading

This project is a git repository with submodules.  To check it out, clone this root repository:

`git clone https://github.com/couchbase/couchbase-lite-java-ce-root --recurse-submodules`

or

`git clone https://github.com/couchbase/couchbase-lite-java-ce-root`
`git submodule update --init --recursive`

## Organization

There are two important top level directories:

* ce - This contains directories for product-specific code for each of the two products, Java and Android
* common - This contains code that is used by the entire Java language product family

The other important directory, `core` contains the code for Couchbase Lite Core.  Both products depend on a LiteCore library.  The Android product builds it as part of a normal build.  The Java AppServer product does not  but there are tools in this repository that will build it and put it in the right place.

## Building

To build a product, navigate to the product home directory (ce/android or ce/java) and follow the detailed insturctions there.

Note: the top level gradle build will build both products, but only if both are correctly configured.  At the very least, you will need:

* local.properties files in this and both product directories
* a LiteCore binary in `./common/lite-core/`

## License

Apache 2 [license](LICENSE).

