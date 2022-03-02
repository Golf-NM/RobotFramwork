*** Settings ***
Library    SeleniumLibrary
Resource    D:/Robotframework/Script_Robotframework/Robotframework_example/Demo_Command-Variable-Softr.robot

*** Test Cases ***
Login - 001
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL-001}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS-001}
    Click Sign in Button
    Check error message "Invalid email or password"
    Close Website Softr
Login - 002
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL-002}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS-002}
    Click Sign in Button
    Check error message "Invalid email or password"
    Close Website Softr
Login - 003
    Open Website Softr
    Input Text    ${LOCATOR_EMAIL}    ${ADMIN_EMAIL-003}
    Input Text    ${LOCATOR_PASSWORD}    ${PASSWORD_LISTS-003}
    Click Sign in Button
    Check error message "Invalid email or password"
    Close Website Softr

*** Keywords ***
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
