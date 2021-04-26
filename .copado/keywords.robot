*** Settings ***
Documentation     Copado Core Regression Tests
Library           QWeb

*** Keywords ***
Setup
    Login

Teardown
    Logout
    Close Browser

Login
    [Tags]       login
    SetConfig    DefaultTimeout     10       # sets default timeout to 60 seconds, affecting all keywords
    SetConfig    SearchMode         draw     # Highlights found elements

    Open Browser     ${url}    chrome
    Type Text        Username    ${user}
    Type Secret        Password    ${password}
    Click Text    Log In
    VerifyText    Home

Logout
    ClickText    View Profile    timeout=5
    ClickText    Log out