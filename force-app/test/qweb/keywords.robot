*** Settings ***
Documentation                   Contains common keywords required for the automation
Library                         String
Library                         QWeb
Library                         Collections
Library                         DateTime
Resource                        variables.robot

*** Keywords ***
Switch To Lightning
    [Documentation]             Switch to lightning if classic view opened
    ${CLASSIC_VIEW}=            RunKeywordAndReturnStatus                               VerifyText                  Switch to Lightning Experience    timeout=2
    RunKeywordIf                ${CLASSIC_VIEW}             ClickText                   Switch to Lightning Experience

Start Suite
    [Documentation]             Setup browser and open Salesforce org

    #SearchMode- To get the blue box as visualization on the screen while element interaction
    #MultipleAnchors- Automation will not give an error if it finds multiple similar anchors, but tries to find/click the text as per anchor.
    #DefaultTimeout- Automation will try to perform an action until 25s, affecting all keywords
    SetConfig                   SearchMode                  draw
    SetConfig                   MultipleAnchors             True
    SetConfig                   DefaultTimeout              25
    SetConfig                   Debug_Run                   True
    Evaluate                    random.seed()               random

    #Steps for test suite setup
    Open Browser                ${AUTH_URL}                chrome

    #Switch to lightning if classic view opened and verify logged-in succesfully
    Switch To Lightning
    VerifyAny                   Home, User

End Suite
    [Documentation]             Logout from Salesofrce ORG and Close browser
    #Steps related to test suite teardown- logout and close the browser after the test suite completion
    ${GET_CURRENT_URL}=         GetUrl
    ${LOGOUT_URL}=              Evaluate                    "https://" + '${GET_CURRENT_URL}'.split('/')[2] + "/secur/logout.jsp"
    GoTo                        ${LOGOUT_URL}               #Logout
    Close All Browsers

Open Object
    [Documentation]             Open Object
    [Arguments]                 ${OBJECT}
    #Open App launcher, type and click object
    ClickText                   App Launcher
    VerifyText                  ${APPS_WEBELEMENT}
    TypeText                    ${SEARCH_APPS_WEBELEMENT}                               ${OBJECT}
    ${OBJECT_XPATH}=            Replace String              ${OBJECT_WEBELEMENT}        OBJECT                      ${OBJECT}
    ClickElement                ${OBJECT_XPATH}
    Check object                ${OBJECT}

Check object
    [Documentation]             Check the object/tab name
    [Arguments]                 ${OBJECT}
    RefreshPage
    ${OBJECT_XPATH_VERIFY}=     Replace String              ${VERIFY_OBJECT_WELELEMENT}                             OBJECT           ${OBJECT}
    VerifyText                  ${OBJECT_XPATH_VERIFY}

Open Show more actions on Details page
    [Documentation]             Click Show more action button if exists
    ${SHOW_MORE_ACTIONS}=       RunKeywordAndReturnStatus                               VerifyText                  Show more actions    timeout=2s
    RunKeywordIf                ${SHOW_MORE_ACTIONS}        ClickText                   Show more actions

Open Show Actions
    [Documentation]             Click Show Actions button as per position, e.g related tab
    [Arguments]                 ${POSITION}
    VerifyNoText                Loading
    ClickText                   Show Actions                ${POSITION}
    Sleep                       2                           #Handle loading issue

Delete and verify
    [Documentation]             Click Delete Button, Confirm and Verify
    VerifyText                  Delete
    ClickText                   Delete
    ClickText                   Delete
    VerifyText                  was deleted

Delete record from object details page
    [Documentation]             Delete the record by clicking delete button available on the object details page
    VerifyNoText                Loading
    #Click show more actions button
    ClickText                   Show more actions
    #Delete record
    Delete and verify

Delete record from object main page
    [Documentation]             Delete the record on the object main page
    [Arguments]                 ${RECORD}
    #Search record
    Search record on object main page                       ${RECORD}
    Open Show Actions           1
    #Delete record
    Delete and verify

Delete Record from related tab
    [Documentation]             Delete the record from related tab by clicking Show Actions button as per position
    [Arguments]                 ${POSITION}
    Open Show Actions           ${POSITION}
    Delete and verify

Delete record from Object
    [Documentation]             Delete the record from object
    [Arguments]                 ${OBJECT}                   ${RECORD}
    Open Object                 ${OBJECT}
    Delete record from object main page                     ${RECORD}

Update record
    [Documentation]             Update the data for record
    [Arguments]                 ${FIELD}
    ${FIELD_TO_UPDATE}=         Evaluate                    "Edit " + "${FIELD}"
    ClickText                   ${FIELD_TO_UPDATE}
    ${NEW_TEXT}=                Generate random name
    TypeText                    ${FIELD}                    ${NEW_TEXT}
    ClickText                   Save
    VerifyText                  ${NEW_TEXT}

Generate random name
    [Documentation]             Generate random name and return
    ${RANDOM_STRING1}=          Generate Random String
    ${RANDOM_STRING2}=          Generate Random String      6                           [NUMBERS]
    ${NAME}=                    Evaluate                    "Random_" + "${RANDOM_STRING1}" + "${RANDOM_STRING2}"                #Using random string twice to avoid duplicate name
    [Return]                    ${NAME}

Get Username
    [Documentation]             Return Username of the org
    ClickText                   View profile
    VerifyText                  Settings                    #To check drop-down opened
    ${USER}=                    GetText                     ${USER_WEBELEMENT}
    ClickText                   View profile
    [Return]                    ${USER}

Search record on object main page
    [Documentation]             Search record on object main page
    [Arguments]                 ${RECORD}
    Run Keyword And Ignore Error                            ClickText                   Select List View
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyText                  All              timeout=5s
    Run Keyword If              ${ISPRESENT}                ClickText                   All
    Run Keyword And Ignore Error                            ClickText                   ALL Env                     timeout=2s
    VerifyNoText                Loading
    PressKey                    Search this list...         ${RECORD}
    VerifyNoText                Loading
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading
    ${SEARCHED_RECORD}=         Replace String              ${SEARCHED_RECORD_WEBELEMENT}                           RECORD           ${RECORD}
    VerifyText                  ${SEARCHED_RECORD}
    VerifyNoText                No items to display

Select The List View
    [Documentation]             Search record on object main page
    ClickText                   Select List View
    ${ALLBUTTON}=               Run Keyword And Return Status                           VerifyText                  All              timeout=5s
    Run Keyword If              ${ALLBUTTON}                ClickText                   All
    ...                         ELSE                        ClickText                   ALL Env
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading

Clone record
    [Documentation]             Clone the record by changing the field value
    [Arguments]                 ${FIELD}                    ${ANCHOR}
    ClickText                   Show more actions
    ${CLONE_BUTTON_STATUS}=     RunKeywordAndReturnStatus                               VerifyText                  Clone            timeout=2
    RunKeywordIf                ${CLONE_BUTTON_STATUS}      ScrollText                  Clone
    ClickText                   Clone
    ${NEW_TEXT}=                Generate random name
    VerifyText                  ${ANCHOR}                   timeout=60s
    Enter Input Field           ${FIELD}                    ${NEW_TEXT}
    ClickText                   Save                        2
    VerifyText                  ${NEW_TEXT}

Select record from lookup field
    [Documentation]             Search and select the record in the lookup field
    [Arguments]                 ${FIELD}                    ${RECORD}
    PressKey                    ${FIELD}                    ${RECORD}
    VerifyText                  Show All Results
    PressKey                    ${FIELD}                    {ENTER}
    VerifyText                  ${CANCEL_BUTTON_WEBELEMENT}                             #Checking modal openend
    ${RECORD_WEBELEMENT}=       Replace String              ${SELECT_RECORD_WEBELEMENT}                             RECORD           ${RECORD}
    ClickText                   ${RECORD_WEBELEMENT}


Open record from object main page    
    [Documentation]             To open the record like Environment/User from the object main page
    [Arguments]                 ${RECORD}
    Search record on object main page                       ${RECORD}
    ClickText                   ${RECORD}
    Sleep                       2s                          #To load new record page

Refresh page browser
    [Documentation]             Refresh the browser for every 6 seconds
    RefreshPage
    Sleep                       6s

Check record result until status change
    [Documentation]             Checks the Status and refresh the page until status is changed
    [Arguments]                 ${CURRENT_STATUS}
    FOR                         ${INDEX}                    IN RANGE                    0                           ${10}
        ${IS_STATUS}=           IsText                      ${CURRENT_STATUS}
        Run Keyword If          ${IS_STATUS}                Refresh page browser
        ...                     ELSE                        Exit For Loop
    END

Select value from dropdown list
    [Documentation]             Clicks the dropdown/combobox and selects the value
    [Arguments]                 ${FIELD_NAME}               ${FIELD_VALUE}              ${ANCHOR_TAG}
    ClickText                   ${FIELD_NAME}               anchor=${ANCHOR_TAG}
    ClickText                   ${FIELD_VALUE}              anchor=--None--

Check The Number Of Records
    [Documentation]             To check if any of the records are present when clicking on ALL
    ${RECORD_FOUND}=            GetElementCount             ${RECORDCOUNT_WEBELEMENT}                               timeout=2
    RunKeywordIf                ${RECORD_FOUND}<=0          VerifyText                  No items to display.

Verify File Content
    [Documentation]             To verify the content is present in the latest downloaded file
    [Arguments]                 ${EXPECTED_CONTENTS}        #The argument works with strings, lists, and anything that supports Python's in operator.
    ${FILE_CONTENT}=            Get File Content
    ${LENGTH}=                  Get Length                  ${EXPECTED_CONTENTS}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${VALUE}=               Get From List               ${EXPECTED_CONTENTS}        ${I}
        Should Contain          ${FILE_CONTENT}             ${VALUE}                    msg=The file doesnt contain the expected content: ${VALUE}
    END

Get ContextId
    [Documentation]             To get the context id from any Object
    ${CURRENT_URL}=             Get Url
    ${CONTEXT_ID}=              Evaluate                    '${CURRENT_URL}'.split('/')[6]
    [Return]                    ${CONTEXT_ID}

Enter Input Field
    [Documentation]             To enter value to any input field using xpath
    [Arguments]                 ${LABEL_NAME}               ${VALUE}
    ${ELEMENT}=                 Replace String              ${INPUT_FIELD_WEBELEMENT}                               LABEL            ${LABEL_NAME}
    VerifyElement               ${ELEMENT}                  timeout=60s
    TypeText                    ${ELEMENT}                  ${VALUE}

Delete All
    [Documentation]             To delete all the created datas in the specified object
    ${COUNT}=                   GetElementCount             ${SHOW_ACTIONS_WEBELEMENT}
    ${LENGTH}=                  Evaluate                    ${COUNT} + 1
    FOR                         ${I}                        IN RANGE                    1                           ${LENGTH}
        VerifyElement           ${SHOW_ACTION_WEBELEMENT}
        ClickElement            ${SHOW_ACTION_WEBELEMENT}
        SetConfig               PartialMatch                False
        VerifyText              Delete
        ClickText               Delete
        VerifyText              Delete                      anchor=Cancel
        ClickText               Delete                      anchor=Cancel
        SetConfig               PartialMatch                True
        VerifyNoText            Loading
        VerifyNoText            was deleted
    END

Get ID from toast message window
    [Documentation]             Returns the ID from toast message window, example: EPIC- Epic "E0000020" was created.
    ${ID}=                      GetText                     ${TOAST_MESSAGE_WEBELEMENT}                             #To get the ID from toast message window
    ${NEW_ID}=                  Evaluate                    '${ID}'.replace('\"', '')                               #To Replace the double quotation from ID String
    [Return]                    ${NEW_ID}


Create New Account
    [Documentation]             Create new account and return name
    #Open New Application window and enter the details
    ${USER}=                    Get Username
    ClickText                   New
    VerifyText                  New Account
    ${ACCOUNT_NAME}=            Generate random name
    Enter Input Field           Account Name                ${ACCOUNT_NAME}
    #Save and verify new record created succesfully
    ClickText                   Save                        2
    VerifyText                  Details
    VerifyText                  ${ACCOUNT_NAME}         anchor=Information
    [Return]                    ${ACCOUNT_NAME}

Open Developer console
    [Documentation]    To open the developer console window

    ClickText          Setup
    VerifyText         Developer Console
    ClickText          Developer Console
    Sleep              3s                          reason=To wait for the next tab to open
    SwitchWindow       NEW
    VerifyText         Debug

Execute Script
    [Documentation]    To execute an apex code in the developer console
    
    [Arguments]        ${SCRIPT}
    VerifyNoText       Loading
    PressKey           Debug                       {CONTROL + E}
    VerifyText         Enter Apex Code
    PressKey           Enter Apex Code             {CONTROL + A}
    VerifyText         Enter Apex Code
    PressKey           Enter Apex Code             {BACKSPACE}
    VerifyText         Enter Apex Code
    TypeText           Enter Apex Code             ${SCRIPT}
    SetConfig          PartialMatch                False
    VerifyText         Execute
    ClickText          Execute
    SetConfig          PartialMatch                True
    VerifyText         Executing
    VerifyNoText       Executing
    Sleep              5s                        reason=To wait until the console execution to start
    CloseWindow
    SwitchWindow       NEW