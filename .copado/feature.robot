*** Settings ***
Library           	QWeb

Resource          	copado.robot
Resource          	application.robot

*** Keywords ***
Open User Story Tab
    ClickText     App Launcher
    Sleep         2s
    TypeText      Search apps and items...  User Stories
    ClickElement  //*[@id\="copado__User_Story__c"]

    Create User Story
    [Tags]      US-2142
    
    ClickText         New
    Sleep         2s
    SwitchWindow     NEW
    ClickText         User Story
    ClickText         Next
    SwitchWindow     NEW
    Sleep         2s
    ${userStoryTitle}=      Generate Random String
    TypeText          //*[@name\="copado__User_Story_Title__c"]   ${userStoryTitle}

    #Enter Project and select
    PressKey          Search Projects...    CopadoAutomationPipeline
    Sleep             3s
    PressKey          Search Projects...    {Enter}
    ClickText         CopadoAutomationPipeline

    #Enter Credential and select
    PressKey          Search Credentials...    automationdev1@copado.com    {Enter}
    PressKey          Search Credentials...    {Enter}
    ClickText         automationdev1@copado.com   anchor=Cancel              timeout=5s
    
    #Save the US and wait for the page load
    ClickText         Save                2
    Sleep             3s
    [Return]          ${userStoryTitle}

OpenContactObjectOnDeveloperORG
    [Documentation]   Open the Contact Object on developer ORG mentioned in the US
    ClickText         Open Org
    Sleep             5s
    SwitchWindow      2                 #Switch to developer ORG
    ClickText         Object Manager
    TypeText          Quick Find        Contact
    ClickText         Contact
    ClickText         Fields & Relationships

AddFieldToDeveloperORG
    [Documentation]   Add the field to developer ORG
    OpenContactObjectOnDeveloperORG
    ClickText         New
    ClickText         Text
    ClickText         Next
    ${fieldName}=      Generate Random String
    TypeText          MasterLabel       ${fieldName}
    TypeText          Length            10
    ClickText         Next
    ClickText         Next
    ClickText         Save
    Sleep             2s
    #Verify field created
    TypeText          Quick Find        ${fieldName}
    VerifyNoText      No items to display.          4s
    VerifyText        ${fieldName}      css=off
    CloseWindow       #To close the }current developer ORG window
    [Return]          ${fieldName

Enable Promote and Deploy
    [Documentation]   Enable "Promote and Deploy" for User Story
    ClickText         Edit Promote and Deploy
    ScrollText        Deployment Options
    ClickElement      xpath\=//*[@class\="slds-checkbox slds-checkbox_standalone"]//input[@name\="copado__Promote_and_Deploy__c"]   #need to refactor
    ClickText         Save

OpenDeploymentPageThroughUS
    ClickText         Promotions
    ClickElement      xpath\=//lightning-primitive-cell-factory[@data-label\="Promotion Name"]/span/div
    Sleep             80s
    RefreshPage
    VerifyNoText      Reset the status of this job      120s
    ClickText         CD: Deploy
    Sleep             70s                #this can be handle through runblock but it is having some issue (ticket raise to qentinel)
    RefreshPage