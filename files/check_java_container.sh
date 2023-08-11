#!/bin/bash

DIR_NAME="$1"
shift
VERSION="$1"
test -z "${DIR_NAME}" && echo "First argument as dir name has to be specified" && exit 1
test -z "${VERSION}" && echo "Second argument as version has to be specified" && exit 1

PWD=`pwd`
cd "${DIR_NAME}"
bash run.sh --jdk-version="${VERSION}"
cd "${PWD}"
