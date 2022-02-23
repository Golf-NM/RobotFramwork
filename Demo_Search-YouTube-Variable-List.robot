*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.youtube.com/
${BROWSER}    chrome
${LOCATOR-SEARCH}    name:search_query
${XPATH-FRIST-ELEMENT}    css=.miniplayer-title.style-scope.ytd-miniplayer
@{WORD-SEARCH}    นนท์ พิง    เกรท    ลิปตา    ว่าน ธนกฤต
@{VALUE-FRIST-ELEMENT}    [เพลงจากละครกระเช้าสีดา] - นนท์ ธนนท์    เกรท วรินทร เผยเคยแอบชอบ แพท ณปภา 😳 | Talk Part 2

*** Keywords ***

*** Test Cases ***
Search "${WORD-SEARCH}[0]" From YouTube
    Open browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Element Should Be Visible    ${LOCATOR-SEARCH}
    Input Text    ${LOCATOR-SEARCH}    ${WORD-SEARCH}[0]
    Press Keys    ${LOCATOR-SEARCH}    RETURN
    Page Should Contain Element    ${XPATH-FRIST-ELEMENT}    ${VALUE-FRIST-ELEMENT}[0]
    Close Browser

Search "${WORD-SEARCH}[1]" From YouTube
    Open browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Element Should Be Visible    ${LOCATOR-SEARCH}
    Input Text    ${LOCATOR-SEARCH}    ${WORD-SEARCH}[1]
    Press Keys    ${LOCATOR-SEARCH}    RETURN
    Page Should Contain Element    ${XPATH-FRIST-ELEMENT}    ${VALUE-FRIST-ELEMENT}[1]
    Close Browser


    

