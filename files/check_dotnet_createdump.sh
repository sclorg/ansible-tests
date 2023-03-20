#!/bin/bash

POD_NAME="$1"
shift

EXPECTED_RESULT="Dump successfully written"

test -z "${POD_NAME}" && echo "'pod_name' variable is not defined in yml" && exit 1

# Get the runtime version
# Technically, this gets the ASP.NET version, but they should be the same.
# If it is ever the case that they are not, you could grep for Microsoft.NETCore.App first
VERSION=$(oc exec ${POD_NAME} -t -- /bin/bash -c "dotnet --list-runtimes | grep -P -o -m 1 [0-9].[0-9].[0-9]\+")
echo ${VERSION}
# Get the executable path
DOTNET_HOME=$(oc exec ${POD_NAME} -t -- /bin/bash -c 'dirname $(readlink -f $(command -v dotnet))')
echo ${DOTNET_HOME}

# It seems the dotnet application is always PID 1 in the container.
OUTPUT=$(oc exec ${POD_NAME} -t -- /bin/bash -c "${DOTNET_HOME}/shared/Microsoft.NETCore.App/${VERSION}/createdump 1 2>&1")
echo ${OUTPUT}
if [ -z "${OUTPUT##*${EXPECTED_RESULT}*}" ]; then
        exit 0
fi
echo "DID NOT FIND A MESSAGE CONFIRMING A PROCESS DUMP WAS CREATED." 1>&2
exit 1
