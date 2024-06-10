#!/bin/bash

POD_NAME="$1"
test -z "${POD_NAME}" && echo "pod_name variable is not defined in yml" && exit 1

POD_RESULT_NAME=""
for i in {1..10}; do
  POD_STATUS=$(oc get pods --no-headers -o custom-columns=NAME:.metadata.name,STATUS:.status.phase \
              | grep -v "${POD_NAME}-1-build" | grep -v "${POD_NAME}-1-deploy" \
              | grep "${POD_NAME}" | sed 's/  */ /g')
  # In case more lines, let's go through all of them
  while read -r line; do
    POD_RUNNING=$(echo "$line" | cut -d ' ' -f 1)
    POD_STATE=$(echo "$line" | cut -d ' ' -f 2)
    if [ x"${POD_STATE}" == "xRunning" ]; then
      if [ x"${POD_RESULT_NAME}" != x"${POD_RUNNING}" ]; then
        POD_RESULT_NAME="${POD_RUNNING}"
      else
        echo "$POD_RESULT_NAME"
        exit 0
      fi
    fi
    if [ x"${POD_STATE}" == "xFailed" ]; then
      exit 1
    fi
  done <<< "${POD_STATUS}"
  sleep 30
done
exit 1
