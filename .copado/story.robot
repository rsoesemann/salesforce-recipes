*** Settings ***
Documentation           Test US Object -Commit and Promote
Resource                ../resources/keywords.robot
Suite Setup             Start Suite
Suite Teardown          End Suite

*** Test Cases ***
Already Commited User Story is rejected
    [Tags]  US-23523 TE-453245234 
    [Documentation] fghgh
    
    # Setup  
    ${story} Create Story
    CommitStory ${story}

    Delete Story {}
    

    # Exercise
    CommitStory ${story}
    

    # Verify
    VerifyText Commit Failed ..



*** Keywords ***

CreateStory


DeleteStory



*** Keywords ***

CreateStory
    [Arguments] ${name}
    ClickText 

    VerifyText
