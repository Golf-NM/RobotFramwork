*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://app.appsmith.com/applications/600186605b452f525458d6d2/pages/600186605b452f525458d6d4/?utm_source=github&utm_medium=direct&utm_content=appsmith_apps&utm_campaign=null&utm_term=appsmith_apps
${BROWSER}    Chrome

${L-TIME}    css=.sc-bmFGeJ .bp3-button
${L-TIME-SELECT}    xpath=//div[text()='2 hour Meeting']
${L-TIME-AFTERSELECT}    xpath=//span[text()='2 hour Meeting']
${VALUE-TIME-AFTERSELECT}    2 hour Meeting

${L-DATE}    css=.bp3-input-group
${L-DATE-PICKER}    css=.bp3-datepicker
${L-DATEPICKER-SELECT}    xpath=//div[text()='31']
${VALUE-DATEPICKER-SELECT}    31/03/2022
${L-DATE-INPUT}    css=.bp3-input

${L-BUTTON-ALL}    css=.sc-buEPGk.cfzZUs
${L-BUTTON-SCHEDULE}    xpath=//*[contains(@class, 'tbody')]/div[6]/div[2]/div/div/button/span

${L-BLOCK-NAME}    css=.iOooAg
${L-YOURNAME}    xpath=//div[@class='sc-dAMSGw dvKaGe']//input[@type='text']
${VALUE-YOURNAME}    Testname
${L-YOUREMAIL}    xpath=//input[@type='email']
${VALUE-YOUREMAIL}    test@email.com
${L-MEETINGPURPOSE}    xpath=//textarea[@class='bp3-input']
${VALUE-MEETINGPURPOSE}    Meeting purpose , Testname , test@email.com
${L-BUTTON-CONFIRM}    css=#comment-overlay-wrapper-jc9eq60y61 .bp3-button

${VALUE-BLOCK-NAME}    Block 21:30 - 23:30 
${L-TITLE-MEETING}     css=#comment-overlay-wrapper-5zay38rmxc .sc-dwqidc > span > h2

*** Test Cases ***
Calendar - Select date and time 
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window

    Wait Until Page Contains Element   ${L-TIME}
    Click Button    ${L-TIME}
    Wait Until Page Contains Element    ${L-TIME-SELECT}
    Click Element    ${L-TIME-SELECT}
    Wait Until Page Contains Element   ${L-TIME-AFTERSELECT}
    ${Input-Time}=    Get text    ${L-TIME-AFTERSELECT}
    Should Be Equal    ${Input-Time}    ${VALUE-TIME-AFTERSELECT}    

    Click Element    ${L-DATE}
    Wait Until Page Contains Element    ${L-DATE-PICKER}
    Click Element    ${L-DATEPICKER-SELECT}
    ${Input-Date}=    Get value    ${L-DATE-INPUT} 
    # Log to console    ${Input-Date}
    Should Be Equal    ${Input-Date}    ${VALUE-DATEPICKER-SELECT}
    Wait Until Page Contains Element    ${L-BUTTON-ALL}

    Click Element    ${L-BUTTON-SCHEDULE}
    Wait Until Page Contains Element    ${L-BLOCK-NAME}
    ${Block-Name}=    Get Text    ${L-BLOCK-NAME}
    log    ${Block-Name}
    Should Be Equal    ${Block-Name}    ${VALUE-BLOCK-NAME}

    Input Text    ${L-YOURNAME}    ${VALUE-YOURNAME}
    Input Text    ${L-YOUREMAIL}    ${VALUE-YOUREMAIL}
    Input Text    ${L-MEETINGPURPOSE}    ${VALUE-MEETINGPURPOSE}
    Click Button    ${L-BUTTON-CONFIRM}
    
    Wait Until Element Contains    ${L-TITLE-MEETING}    Testname Meeting with Nikhil
    ${VALUE-TITLE-MEETING}=    Get Text    ${L-TITLE-MEETING}
    log   ${VALUE-TITLE-MEETING}
       
    Should Be Equal    ${VALUE-TITLE-MEETING}    Testname Meeting with Nikhil
    Capture Page Screenshot    Calendar-Selenium_{index}.png
    # Get All Links




   



    