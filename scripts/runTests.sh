#!/bin/bash

echo "> QWeb tests"
INSTANCE="$(sfdx force:org:display --verbose --json | jq -r '.result.instanceUrl')"
SID="$(sfdx force:org:display --verbose --json | jq -r '.result.accessToken')"
URL=$INSTANCE/secur/frontdoor.jsp?sid=$SID
robot --variable AUTH_URL:$URL functional-tests.robot 

echo "> Apex tests"
execute sfdx force:apex:test:run -l RunLocalTests --synchronous

echo "> Salesforce CLI Scanner"
execute sfdx scanner:run --target "force-app" --pmdconfig "ruleset.xml"

echo "> Jest tests"
if [ -f "package.json" ]; then
  echo "Running jest tests"
  execute npm install 
  execute npm run test:unit
fi