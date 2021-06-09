*** Settings ***
Library             QWeb

*** Variables ***
${authurl}          https://copado32-dev-ed.my.salesforce.com/secur/frontdoor.jsp?sid=00D09000003RdYH!ARgAQEkPCXAvkH1eMQHslUx.cs.d7pi5IxKdI89kTRIfZeWwjFgDDjijqi3r773QsxSy3JecG6Ry3Y0fpPmlKxjk4GO05KM1

*** Keywords ***
Login to Salesforce
    Open Browser    ${authurl}   chrome
    VerifyText      User


Logout from Salesforce
    ClickItem         User
    ClickText         Log Out
    Close All Browsers
