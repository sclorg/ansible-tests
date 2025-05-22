#!/bin/bash

POD_NAME="$1"
EXPECTED_RESULT="$2"

test -z "${POD_NAME}" && echo "'pod_name' variable is not defined in yml" && exit 1
test -z "${EXPECTED_RESULT}" && echo "'expected_results' variable is not defined in yml" && exit 1

OUTPUT=$(oc exec ${POD_NAME} -it -- /bin/sh -i -c timeout 15 valkey-cli -h 127.0.0.1 -a testp ping || echo WRONG)
echo ${OUTPUT}
if [ "${OUTPUT}" == "${EXPECTED_RESULT}" ]; then
    exit 0
fi
exit 1
