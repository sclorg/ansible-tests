#!/bin/bash

DIR_NAME="$1"
shift
VERSION="$1"
test -z "${DIR_NAME}" && echo "First argument as dir name has to be specified" && exit 1
test -z "${VERSION}" && echo "Second argument as version has to be specified" && exit 1

PWD=`pwd`
cd "${DIR_NAME}"
MAVEN_HOME=/usr/bin/  mvn clean test -P "${VERSION}" -P smoke -Dmaven.home=/usr/bin/
cd "${PWD}"
