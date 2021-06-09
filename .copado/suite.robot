*** Settings ***
Suite Setup             LoginToCopadoLatestRelease
Suite Teardown          EndSuite

*** Test Cases ***

Already Commited User Story is rejected
    [Tags]  UserStory Commit Exceptions
    
    # Setup
    ${story} CreateStory 
    SubmitStory ${story}
    CommitStory ${story} 


    # Exercise
    CommitStory ${story}


    # Verify
    VerifyText Commit failed

*** Keywords ***

Create Story
    [Arguments]           ${storyName}   ${epicName}

    ClickText         Edit Team Name
    WriteText         Update
    ClickText         Save
    ClickText         Save              js=true
    VerifyText        ${teamName}Update