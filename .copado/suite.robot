*** Settings ***
Suite Setup             LoginToCopadoLatestRelease
Suite Teardown          EndSuite

*** Test Cases ***

Admin successfully deletes User
    
    # Setup
    AppState ...

    # Exercise
    ClickText         Edit Team Name
    WriteText         Update
    ClickText         Save

    # Verify
    VerifyText Commit failed
Non-Admin fails to delete User
    
    # Setup
    AppState ...

    # Exercise
    ClickText         Edit Team Name
    WriteText         Update
    ClickText         Save

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