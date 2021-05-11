#!/bin/bash

POD_NAME="$1"

test -z "${POD_NAME}" && echo "pod_name variable is not defined in yml" && exit 1

POD_RUNNING=$(oc get pods --no-headers -o custom-columns=NAME:.metadata.name,STATUS:.status.phase \
            | grep -v "${POD_NAME}-1-build" | grep -v "${POD_NAME}-1-deploy" \
            | grep "${POD_NAME}" | cut -d' ' -f 1)
if [ x"${POD_RUNNING}" != "x" ]; then
    echo "${POD_RUNNING}"
    exit 0
fi
exit 1
