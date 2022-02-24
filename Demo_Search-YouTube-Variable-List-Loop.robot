*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}    https://www.youtube.com/
${BROWSER}    chrome
${LOCATOR-SEARCH}    name:search_query
${XPATH-FRIST-ELEMENT}    css=.miniplayer-title.style-scope.ytd-miniplayer
@{LIST-WORD-TAG-SEARCH}    นนท์ พิง    เกรท    ว่าน ธนกฤต    ลิปตา

*** Test Cases ***
Search From YouTube
    FOR    ${WORD-SEARCH}    IN    @{LIST-WORD-TAG-SEARCH}
        Open browser    ${URL}    ${BROWSER}
        Maximize Browser Window
        Element Should Be Visible    ${LOCATOR-SEARCH}
        Input Text    ${LOCATOR-SEARCH}    ${WORD-SEARCH}
        Press Keys    ${LOCATOR-SEARCH}    RETURN
        Sleep    3s
        Title Should Be    ${WORD-SEARCH} - YouTube
        Capture Page Screenshot    Variable-List-{index}.png
        Close Browser
    END






    

