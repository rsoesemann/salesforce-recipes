#!/bin/bash

echo "Running QWeb tests"
AUTH_URL="$(sfdx force:org:display --verbose --json | jq '.result.sfdxAuthUrl')"
robot test/qweb/functional-tests.robot --variable AUTH_URL:$AUTH_URL 

echo "Running apex tests"
#execute sfdx force:apex:test:run -l RunLocalTests --synchronous

echo "Runnint Jest tests"

if [ -f "package.json" ]; then
  echo "Running jest tests"
  execute npm install 
  execute npm run test:unit
fi