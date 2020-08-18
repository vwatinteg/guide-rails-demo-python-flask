#!/bin/bash

set -ex
STATUS=$(curl --silent --output /dev/stderr --write-out "%{http_code}" http://localhost:5000)
if [ "$STATUS" != 200 ]; then 
  echo "Buzz application is not running. Exiting!"
  exit 1
else
  echo "Buzz application is running at http://localhost:5000"
fi
set +e
