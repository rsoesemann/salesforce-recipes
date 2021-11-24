*** Settings ***
Documentation                   Functional tests

Resource                        force-app/test/qweb/keywords.robot

Suite Setup                     Start Suite
Suite Teardown                  End Suite

*** Test Cases ***

Create, Update and Delete Account
    [Tags]                      Accounts
    [Documentation]             
    #Usecase:
    #1. Open the Account window
    #2. Create a new Account by filling in all details
    #3. Verify successfully created the account
    #4. Update the account and verify it
    #5. Delete account and verify it

    #Given
    Open Object                 Accounts

    #When
    Create New Account

    #Then
    Update record               Name
    Delete record from object details page