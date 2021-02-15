*** Settings ***
Library    SeleniumLibrary
Variables    locators/fnjv.py

*** Keywords ***
Navigate to FNJV Site
    Go To    ${fnjvUrl}
    
Click On Sound Collection Link
    Wait Until Element is Visible    ${soundCollectionLink}
    Click Element    ${soundCollectionLink}

Wait Until Spinner is Not Visible
    Wait Until Element Is Not Visible    ${spinner}

Expand Search Block
    Wait Until Element Is Visible    ${searchTitle}
    ${isNotVisible}    Run Keyword and Return Status    Element Should Not Be Visible    ${searchBlock}
    Run Keyword If    ${isNotVisible}    Click Element    ${searchTitle}

