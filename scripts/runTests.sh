#!/bin/bash

echo "Running QWeb tests"
AUTH_URL="$(sfdx force:org:display --verbose --json | jq '.result.sfdxAuthUrl')"
eho $AUTH_URL
robot --variable AUTH_URL:$AUTH_URL functional-tests.robot 

echo "Running apex tests"
#execute sfdx force:apex:test:run -l RunLocalTests --synchronous

echo "Running Jest tests"

if [ -f "package.json" ]; then
  echo "Running jest tests"
  execute npm install 
  execute npm run test:unit
fi