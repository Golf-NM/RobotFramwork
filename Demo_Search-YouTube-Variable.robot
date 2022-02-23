*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.youtube.com/
${BROWSER}    chrome
${LOCATOR-SEARCH}    name:search_query
${WORD-SEARCH}    นนท์ พิง
${XPATH-FRIST-ELEMENT}    //*[@id="video-title"]/yt-formatted-string
${VALUE-FRIST-ELEMENT}    [เพลงจากละครกระเช้าสีดา] - นนท์ ธนนท์
${XPATH-CLICK-ELEMENT}    //ytd-video-renderer[@class='style-scope ytd-item-section-renderer'][1]
${XPATH-THANKS-ELEMENT}    //yt-formatted-string[contains(text(),'No thanks')]

*** Keywords ***

*** Test Cases ***
Search "นนท์ พิง" From YouTube
    Open browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Element Should Be Visible    ${LOCATOR-SEARCH}
    Input Text    ${LOCATOR-SEARCH}    ${WORD-SEARCH}
    Press Keys    ${LOCATOR-SEARCH}    RETURN
    Sleep    8s
    Page Should Contain Element    ${XPATH-FRIST-ELEMENT}    ${VALUE-FRIST-ELEMENT}
    Click Element    ${XPATH-CLICK-ELEMENT}
    Sleep    60s
    Click Element    ${XPATH-THANKS-ELEMENT}
    Capture Page Screenshot    Demo-Search-YouTube-{index}.png
    Close Browser



