*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://ps-stock.softr.app/
${BROWSER}    Chrome
${ADMIN_EMAIL-INVALID}    admin@email.com
${PASSWORD_LISTS-INVALID}    Test1234
${ADMIN_EMAIL-VALID}    admin@example.com
${PASSWORD_LISTS-VALID}    123456
${LOCATOR_EMAIL}    sw-form-capture-email-input
${LOCATOR_PASSWORD}    sw-form-password-input
${LOCATOR_SUBMIT}    sw-sign-in-submit-btn
${LOCATOR_INVALID_LOGIN}    css=.login-error
${ERROR_MSG_INVALID_LOGIN}    Invalid email or password
${LOCATOR_CARD}    xpath=//*[contains(@class, 'sw-3-column')]/div


*** Test Cases ***
Login - Invalid Username And Password 
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL-INVALID}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS-INVALID}    
    Click Sign in Button
    Check error message "Invalid email or password"

    Capture Page Screenshot    Login-Softr-Invalid_{index}.png
    Close Browser


Login - Valid Username And Password 
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL-VALID}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS-VALID}    
    Click Sign in Button
    Wait Until Page Contains Element   ${LOCATOR_CARD}

    Capture Page Screenshot    Login-Softr-Valid_{index}.png 
    Close Browser

*** Keywords ***
Open Website Softr
    Open Browser    ${URL}   ${BROWSER}
    Maximize Browser Window
    Page Should Contain    Sign in

Click Sign in Button
    ${Button-SignIn}=  Execute Javascript
    ...  return document.getElementById('sw-sign-in-submit-btn')
    ${Locator-SignIn}=   Set Variable    ${Button-SignIn}
    Wait until keyword succeeds    5s    3s        Set Focus To Element    ${Locator-SignIn}
    Wait until keyword succeeds    5s    3s        Click Element     ${Locator-SignIn}

Check error message "Invalid email or password"
    ${afterInput}=    Execute Javascript    
    ...    return document.getElementsByClassName('login-error')
    ${get_error}=  Set Variable    ${afterInput}
    log    ${get_error}
    Sleep    1s
    Capture Page Screenshot    Login-Softr_{index}.png 
    Element Text Should Be    ${LOCATOR_INVALID_LOGIN}    ${ERROR_MSG_INVALID_LOGIN}
    ${get_error}=  Get Text    ${LOCATOR_INVALID_LOGIN}
    Should Be Equal    ${get_error}    ${ERROR_MSG_INVALID_LOGIN}

    