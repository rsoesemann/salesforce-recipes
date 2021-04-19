*** Settings ***
Documentation     	Copado Core Regression Tests
Library           	QWeb

Resource          	copado.keywords.robot
Resource          	copado.variables.robot

# Suite Setup       Setup
Suite Teardown    	Teardown

*** Variables ***
${url}				https://copadev-rsoesemann-dev-ed.my.salesforce.com/lightning/page/home
${user}				rsoesemann+copadev@copado.com
${password}      	M9kATnebJbH8


*** Test Cases ***

UserStory Single Test
    [Documentation] 	Test title
    [Tags]          US-0020832 USB

    # Setup
    Appstate        Login

    # Exercise
    ClickText       Compliance Rules
    ClickText       New
    ClickText       Next
    TypeText        Compliance Rule Name    My Rule   2
    TypeText        Risk Details            Lorem   2
    SelectText      Severity                Medium
    ClickText       Save                    2
    Sleep           1

    #Verify
    VerifyText      Compliance Rule "My Rule" was created.