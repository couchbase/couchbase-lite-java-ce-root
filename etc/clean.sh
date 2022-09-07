#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for mod in ce common ''; do
    pushd "${SCRIPT_DIR}/../$mod" > /dev/null
    git clean -xdf -e 'local.*' -e '.idea' -e 'lite-core'
    popd > /dev/null
done
