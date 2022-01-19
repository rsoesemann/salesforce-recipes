*** Settings ***
Library                         QWeb
Library                         String
Library                         DebugLibrary

Suite Setup                     Setup
Suite Teardown                  Teardown

*** Test Cases ***

Setup Fails with invalid Named Credential URL
    # Setup
    AppChooser                  Recipes

    # Exercise
    ClickText                   Setup
    TypeText                    Base URL:  invalid://url
    TypeText                    User Name:  John Doe
    TypeText                    Password:   secret
    ClickText                   Execute

    #Verify
    VerifyText                  Endpoint needs to be in full URL form

Setup Successfully Creates Named Credential
    # Setup
    AppChooser                  Recipes

    # Exercise
    ClickText                   Setup
    TypeText                    Base URL:  https://api.acme.com
    TypeText                    User Name:  John Doe
    TypeText                    Password:   secret
    ClickText                   Execute

    # Verify
    VerifyText                  backend set up correctly

    # Teardown
    #OpenSetup                   Named Credentials

*** Keywords ***

Setup
    SetConfig                   SearchMode                  draw
    SetConfig                   MultipleAnchors             True
    SetConfig                   DefaultTimeout              25

    Open Browser                ${AUTH_URL}                chrome

    VerifyAny                   Home, User

Teardown
    GoTo                        "/secur/logout.jsp"      
    Close All Browsers

AppChooser
    [Arguments]                 ${OBJECT}

    ClickText                   App Launcher
    VerifyText                  Apps
    TypeText                    xpath\=//input[@placeholder\="Search apps and items..."]              ${OBJECT}
    ClickText                   ${OBJECT}       2             