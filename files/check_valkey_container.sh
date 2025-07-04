#!/bin/bash

POD_NAME="$1"
EXPECTED_RESULT="$2"

test -z "${POD_NAME}" && echo "'pod_name' variable is not defined in yml" && exit 1
test -z "${EXPECTED_RESULT}" && echo "'expected_results' variable is not defined in yml" && exit 1

OUTPUT=$(set -x;oc exec ${POD_NAME} -it -- valkey-cli -h 127.0.0.1 -a testp ping || echo WRONG)
echo "${OUTPUT}"
if [ "${OUTPUT}" == "${EXPECTED_RESULT}" ]; then
    exit 0
fi
exit 1
