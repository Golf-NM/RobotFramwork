*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open App
Suite Teardown    Close App

*** Variables ***
${URL}    https://ps-stock.softr.app/
${BROWSER}    Chrome
${ADMIN_EMAIL}    admin@example.com
@{PASSWORD_LISTS}    testtest    TESTTEST    12345678    1234567
${LOCATOR_EMAIL}    sw-form-capture-email-input
${LOCATOR_PASSWORD}    sw-form-password-input
${LOCATOR_SUBMIT}    sw-sign-in-submit-btn
${LOCATOR_INVALID_LOGIN}    css=.login-error
${ERROR_MSG_INVALID_LOGIN}    Invalid email or password

*** Test Cases ***
TC 001 : Reset password - password is great
    FOR    ${index}    ${item}    IN ENUMERATE    @{PASSWORD_LISTS}
        Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL}
        Input Text    ${LOCATOR_PASSWORD}    ${item}
        
        ${hidden_objs}=  Execute Javascript
        ...  return document.getElementById('sw-sign-in-submit-btn')
        ${select_obj}=   Set Variable    ${hidden_objs}
        Wait until keyword succeeds    5s    3s        Set Focus To Element    ${select_obj}
        Wait until keyword succeeds    5s    3s        Click Element     ${select_obj}

        ${afterInput}=    Execute Javascript    
        ...    return document.getElementsByClassName('login-error')

        ${get_error}=  Set Variable    ${afterInput}
        log    ${get_error}
        Sleep    1s
        Capture Page Screenshot    Login-Softr_{index}.png 
        Element Text Should Be    ${LOCATOR_INVALID_LOGIN}    ${ERROR_MSG_INVALID_LOGIN}
        ${get_error}=  Get Text    ${LOCATOR_INVALID_LOGIN}
        Should Be Equal    ${get_error}    ${ERROR_MSG_INVALID_LOGIN}
    END
 
*** Keywords ***
Open App
    Open Browser    ${URL}   ${BROWSER}
    Page Should Contain    Sign in

Close App
    Close Browser