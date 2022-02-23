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
    Click Element    //body/ytd-app[1]/div[1]/ytd-page-manager[1]/ytd-search[1]/div[1]/ytd-two-column-search-results-renderer[1]/div[1]/ytd-section-list-renderer[1]/div[2]/ytd-item-section-renderer[1]/div[3]/ytd-video-renderer[1]/div[1]/div[1]/div[1]/div[1]/h3[1]/a[1]/yt-formatted-string[1]
    Sleep    60s
    Close Browser
