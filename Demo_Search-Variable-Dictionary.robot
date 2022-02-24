*** Settings ***
Library    SeleniumLibrary


*** Variables ***
&{URL}    test=https://www.youtube.com    uat=https://www.google.co.th
${BROWSER}    chrome
${LOCATOR-SEARCH}    name:search_query
${XPATH-FRIST-ELEMENT}    css=.miniplayer-title.style-scope.ytd-miniplayer
${LIST-WORD-SEARCH}    นนท์ พิง

*** Test Cases ***
Search From ${URL.test}
    Open browser    ${URL.test}    ${BROWSER}
    Maximize Browser Window
    Element Should Be Visible    ${LOCATOR-SEARCH}
    Input Text    ${LOCATOR-SEARCH}    ${LIST-WORD-SEARCH}
    Press Keys    ${LOCATOR-SEARCH}    RETURN
    Sleep    3s
    Title Should Be    ${LIST-WORD-SEARCH} - YouTube
    Capture Page Screenshot    Variable-Dictionary-{index}.png
    Close Browser

Search From ${URL.uat}
    Open browser    ${URL.uat}    ${BROWSER}
    Maximize Browser Window
    Element Should Be Visible    name=q
    Input Text    name=q    ${LIST-WORD-SEARCH}
    Press Keys    name=q    RETURN
    Sleep    3s
    Title Should Be    ${LIST-WORD-SEARCH} - ค้นหาด้วย Google
    Capture Page Screenshot    Variable-Dictionary-{index}.png
    Close Browser









    

