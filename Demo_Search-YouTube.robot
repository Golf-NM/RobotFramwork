*** Settings ***
Library    SeleniumLibrary
*** Variables ***

*** Keywords ***

*** Test Cases ***
Search "นนท์ พิง" From YouTube
    Open browser    https://www.youtube.com/    chrome
    Maximize Browser Window
    Element Should Be Visible    name:search_query
    Input Text    name:search_query    นนท์ พิง
    Press Keys    name:search_query    RETURN
    Sleep    8s
    Page Should Contain Element    //*[@id="video-title"]/yt-formatted-string    [เพลงจากละครกระเช้าสีดา] - นนท์ ธนนท์
    Click Element    //ytd-video-renderer[@class='style-scope ytd-item-section-renderer'][1]
    Sleep    60s
    Click Element    //yt-formatted-string[contains(text(),'No thanks')]
    Capture Page Screenshot    Demo-Search-YouTube-{index}.png
    Close Browser
