*** Settings ***
Library    SeleniumLibrary

Test Template    Test Login

*** Variables ***
${URL}    https://ps-stock.softr.app/
${BROWSER}    Chrome
${ADMIN_EMAIL}    admin@example.com

${LOCATOR_EMAIL}    sw-form-capture-email-input
${LOCATOR_PASSWORD}    sw-form-password-input
${LOCATOR_SUBMIT}    sw-sign-in-submit-btn
${LOCATOR_INVALID_LOGIN}    css=.login-error
${ERROR_MSG_INVALID_LOGIN}    Invalid email or password

*** Test Cases ***    PASSWORD_LISTS
Case-1                testtest
Case-2                Test1234
Case-3                1234

*** Keywords ***
Test Login
    [Arguments]    ${PASSWORD_LISTS}
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS}
    Click Sign in Button
    Check error message "Invalid email or password"
    Close Website Softr

Open Website Softr
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window
    Page Should Contain    Sign in

Click Sign in Button
    ${hidden_objs}=  Execute Javascript 
    ...  return document.getElementById('sw-sign-in-submit-btn')
    ${select_obj}=   Set Variable    ${hidden_objs}
    Wait until keyword succeeds    5s    3s        Set Focus To Element    ${select_obj}
    Wait until keyword succeeds    5s    3s        Click Element     ${select_obj}

Check error message "Invalid email or password"
    ${afterInput}=    Execute Javascript    
    ...  return document.getElementsByClassName('login-error')
    ${get_error}=  Set Variable    ${afterInput}
    Sleep    1s
    Element Text Should Be    ${LOCATOR_INVALID_LOGIN}    ${ERROR_MSG_INVALID_LOGIN}
    ${get_error}=  Get Text    ${LOCATOR_INVALID_LOGIN}
    Should Be Equal    ${get_error}    ${ERROR_MSG_INVALID_LOGIN}
    Capture Page Screenshot    Login-Softr_{index}.png

Close Website Softr
    Close Browser
