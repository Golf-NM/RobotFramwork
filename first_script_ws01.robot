** Setting ***
Library        SeleniumLibrary
Library        String

*** Variables ***
${url}         https://nejavu.com/
${browser}        edge
${home_page_logo.locator}    xpath=//img[contains(@class,'logo_desktop')]
${search_input.locator}      xpath=//form[@class='search']//input[@name='s']
${text_search}               Super
${text_search.locator}       xpath=//h1[@class='mb-0' and text()='ค้นหา: "trans_search"']
${add_cart_btn.locator}      xpath=//div[text()='$title_book']/ancestor::div[@class="product-list-product"]//button
${dragonball_title.07}       ดราก้อนบอล ซุปเปอร์ เล่ม 7
${dragonball_price.07}       85.50
${dragonball_title.05}       ดราก้อนบอล ซุปเปอร์ เล่ม 5
${dragonball_title.01}       ดราก้อนบอล ซุปเปอร์ เล่ม 1
${total_qty}                 3
${qty_cart_icon.locator}     xpath=//span[@class='basket-quantity']
${title_book.locator}        xpath=//a[text()='$book_name']//ancestor::td[@class='d-none d-md-table-cell basket-product']
${price_book.locator}        xpath=//a[text()='$book_name']//following::td[contains(@class,'basket-price pr-5')]
${qty_book.locator}          xpath=//a[text()='$book_name']//following::td[@class='basket-qty']
${dragonball_qty.05}         1
${expect_qty}                3
${first_basket_remove_button}    xpath=//td[@class='basket-remove']
${basket_empty.locator}    xpath=//div[text()='trans_basket_empty']
${basket_empty.text}       ตะกร้าว่างเปล่า

${GLOBAL_TIMEOUT}    10s
*** Keywords ***
Open nejavu website
    SeleniumLibrary.Open browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window

Page should display logo home page
    SeleniumLibrary.Wait Until Element Is Visible    ${home_page_logo.locator}

Input book search    
    [Arguments]    ${locator}    ${product}
    SeleniumLibrary.Input text    ${locator}    ${product}

Press keys enter book search
    [Arguments]    ${locator}
    SeleniumLibrary.Press keys    ${locator}    ENTER

Page should display book result page
    ${text_search}    String.Replace string    ${text_search.locator}    trans_search    ${text_search}
    SeleniumLibrary.Wait until element is visible    ${text_search}

Click element when ready
    [Arguments]     ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible    ${locator}    ${timeout}
    SeleniumLibrary.Click Element    ${locator}

Get text element when ready
    [Arguments]     ${locator}    ${timeout}=${GLOBAL_TIMEOUT}
    SeleniumLibrary.Wait until element is visible    ${locator}    ${timeout}
    ${value}    SeleniumLibrary.Get Text    ${locator}  
    [Return]    ${value}

Click book to cart successfully
    [Arguments]    ${title}    ${timeout}=${GLOBAL_TIMEOUT}
    ${add_to_cart_btn}    String.Replace String    ${add_cart_btn.locator}    $title_book    ${title}
    SeleniumLibrary.Wait until element is visible    ${add_to_cart_btn}    ${timeout}
    SeleniumLibrary.Click Element    ${add_to_cart_btn}

Verify qty on cart icon
    [Arguments]    ${expect_qty}    ${locator}
    ${actual_qty}    Get text element when ready    ${locator}
    Should Be Equal As Numbers    ${actual_qty}    ${expect_qty}
  
Verify titlebook in basket
    [Arguments]    ${title}
    ${title_book.locator}    String.Replace String    ${title_book.locator}    $book_name    ${title}
    SeleniumLibrary.Wait Until Element Is Visible    ${title_book.locator}
    SeleniumLibrary.Element Text Should Be    ${title_book.locator}    ${title}

Check price book
    [Arguments]    ${title}    ${expect_price}    ${timeout}=${GLOBAL_TIMEOUT}
    ${actual_price}    String.Replace string     ${price_book.locator}    $book_name    ${title}
    SeleniumLibrary.Wait until element is visible    ${actual_price}    ${timeout}
    ${value}    SeleniumLibrary.Get Text    ${actual_price}
    BuiltIn.Should Be Equal As Numbers    ${value}    ${expect_price}

Check qty book    
    [Arguments]    ${title}    ${expect_qty}    ${timeout}=${GLOBAL_TIMEOUT}
    ${actual_qty}    String.Replace string    ${qty_book.locator}    $book_name     ${title}
    SeleniumLibrary.Wait until element is visible    ${actual_qty}    ${timeout}
    ${value}    SeleniumLibrary.Get Text    ${actual_qty} 
    ${actual_qty}    String.Remove String    ${value}    x
    BuiltIn.Should Be Equal As Numbers    ${actual_qty}    ${expect_qty}

Click remove all book
    FOR  ${index}  IN RANGE    50
        ${status}    BuiltIn.Run keyword and return status    SeleniumLibrary.Wait until element is not visible    ${first_basket_remove_button}
        Exit For Loop If    ${status}
        Click element when ready    ${first_basket_remove_button}
    END
    
Page Should display basket empty
    [Arguments]    ${basket_empty}
    ${basket_empty}    String.Replace String    ${basket_empty.locator}    trans_basket_empty    ${basket_empty}
    SeleniumLibrary.Wait until element is visible    ${basket_empty}

Close browser
    SeleniumLibrary.Close browser

*** Test Cases ***
Selected book and remove from cart
    [Tags]    01_ws
    Open nejavu website
    Page should display logo home page
    Input book search    ${search_input.locator}      ${text_search}
    Press keys enter book search    ${search_input.locator}
    Page should display book result page
    Click book to cart successfully    ${dragonball_title.07}
    Click book to cart successfully    ${dragonball_title.05}
    Click book to cart successfully    ${dragonball_title.01}
    Get text element when ready    ${qty_cart_icon.locator}    
    Verify qty on cart icon    ${total_qty}    ${qty_cart_icon.locator}  
    Click element when ready    ${qty_cart_icon.locator}
    Verify titlebook in basket    ${dragonball_title.07}
    Verify titlebook in basket    ${dragonball_title.05}
    Verify titlebook in basket    ${dragonball_title.01}
    Check price book      ${dragonball_title.07}    ${dragonball_price.07}
    Check qty book        ${dragonball_title.05}    ${dragonball_qty.05}
    Click remove all book
    Page Should display basket empty    ${basket_empty.text}
    Close browser
