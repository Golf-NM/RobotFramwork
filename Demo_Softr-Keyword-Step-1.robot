*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://ps-stock.softr.app/
${BROWSER}    Chrome
${ADMIN_EMAIL}    admin@email.com
${ADMIN_PASSWORD}    12345
${LOCATOR_EMAIL}    sw-form-capture-email-input
${LOCATOR_PASSWORD}    sw-form-password-input
${LOCATOR_SUBMIT}    sw-sign-in-submit-btn
${LOCATOR_INVALID_LOGIN}    css=.login-error
${ERROR_MSG_INVALID_LOGIN}    Invalid email or password

*** Test Cases ***
Login - Invalid Username And Password 
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window
    Page Should Contain    Sign in

    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL}
    Input Text    ${LOCATOR_PASSWORD}    ${ADMIN_PASSWORD}    
    
    ${Button-SignIn}=  Execute Javascript
    ...  return document.getElementById('sw-sign-in-submit-btn')
    ${Locator-SignIn}=   Set Variable    ${Button-SignIn}
    Wait until keyword succeeds    5s    3s        Set Focus To Element    ${Locator-SignIn}
    Wait until keyword succeeds    5s    3s        Click Element     ${Locator-SignIn}

    ${afterInput}=    Execute Javascript    
    ...    return document.getElementsByClassName('login-error')

    ${get_error}=  Set Variable    ${afterInput}
    log    ${get_error}
    Sleep    1s
    Capture Page Screenshot    Login-Softr_{index}.png 
    Element Text Should Be    ${LOCATOR_INVALID_LOGIN}    ${ERROR_MSG_INVALID_LOGIN}
    ${get_error}=  Get Text    ${LOCATOR_INVALID_LOGIN}
    Should Be Equal    ${get_error}    ${ERROR_MSG_INVALID_LOGIN}

    Capture Page Screenshot    Login-Softr_{index}.png
    Close Browser

