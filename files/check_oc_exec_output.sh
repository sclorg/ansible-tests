#!/bin/bash

CMD="$1"
shift
POD_NAME="$1"
shift
EXPECTED_RESULT="$1"
shift

test -z "${CMD}" && echo "'cmd' variable is not defined in yml" && exit 1
test -z "${POD_NAME}" && echo "'pod_name' variable is not defined in yml" && exit 1
test -z "${EXPECTED_RESULT}" && echo "'expected_results' variable is not defined in yml" && exit 1

OUTPUT=$(oc exec ${POD_NAME} "$@" -t -- /bin/bash -c "${CMD}")
echo ${OUTPUT}
if [ -z "${OUTPUT##*$EXPECTED_RESULT*}" ]; then
        exit 0
fi
echo "EXPECTED RESULT NOT FOUND IN OUTPUT" 1>&2
exit 1
