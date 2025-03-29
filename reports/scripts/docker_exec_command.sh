#!/bin/bash

COMMAND=""
CONTAINER=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --command|-cmd)
      COMMAND="$2"
      shift;shift;
    ;;
    --container)
      CONTAINER="$2"
      shift;shift;
    ;;
    *)
      echo "Unable to recognize given parameter ${2}"
      exit 1
  esac
done

docker exec ${CONTAINER} bash -c "${COMMAND}"
