*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    JSONLibrary
Library    OperatingSystem
Variables    locators/fnjv.py

*** Keywords ***
Navigate to FNJV Site
    Go To    ${fnjvUrl}
    
Click On Sound Collection Link
    Wait Until Spinner is Not Visible
    Wait Until Element is Visible    ${soundCollectionLink}
    Click Element    ${soundCollectionLink}

Wait Until Spinner is Not Visible
    Wait Until Element Is Not Visible    ${spinner}

Expand Search Block
    Wait Until Element Is Visible    ${searchTitle}
    ${isNotVisible}    Run Keyword and Return Status    Element Should Not Be Visible    ${searchBlock}
    Run Keyword If    ${isNotVisible}    Click Element    ${searchTitle}

Click on Phylum Selector
    Wait Until Spinner is Not Visible
    Wait Until Element Is Visible    ${phylumSelector}
    Click Element    ${phylumSelector}

On Phylum Selector, Select Chordata Option
    Click on Phylum Selector
    Wait Until Element Is Visible    ${phylumSelectorResults}
    Wait Until Page Contains Element    ${chordataOption}
    Click Element    ${chordataOption}

Wait Until Class Spinner is Not Visible
    Wait Until Element Is Not Visible    ${classSpinner}

Click on Class Selector
    Wait Until Class Spinner is Not Visible
    Wait Until Element Is Visible    ${classSelector}
    Click Element    ${classSelector}

On Class Selector, Select Amphibia Option
    Click on Class Selector
    Wait Until Page Contains Element    ${amphibiaOption}
    Click Element    ${amphibiaOption}

Wait Until Order Spinner is Not Visible
    Wait Until Element Is Not Visible    ${orderSpinner}

Click on Order Selector
    Wait Until Order Spinner is Not Visible
    Wait Until Element Is Visible    ${orderSelector}
    Click Element    ${orderSelector}

On Order Selector, Select Anura Option
    Click on Order Selector
    Wait Until Page Contains Element    ${anuraOption}
    Click Element    ${anuraOption}
    
Click On Search Button
    Wait Until Element is Visible    ${searchButton}
    Click Element    ${searchButton}

Get Number Of Pages in Search Results
    Wait Until Element is Visible    ${numberOfPages}
    ${numberOfPages}    Get Text    ${numberOfPages}
    [Return]    ${numberOfPages}

Click On Next Page Button
    Wait Until Element Is Visible    ${nextPage}
    Click Element    ${nextPage}
    Sleep    2

Download All Records in Search Results
    ${numberOfPages}    Get Number Of Pages in Search Results
    ${animals}    Create List
    FOR    ${page}    IN RANGE    3   #${numberOfPages}
        ${pageAnimals}    Download Animals in Page
        ${animals}    Combine Lists    ${animals}    ${pageAnimals}
        Run Keyword If    ${page}<${numberOfPages}-1    Click On Next Page Button
    END
    ${animalData}    Create Dictionary    animals=${animals}
    Create Animals Json    ${animalData}

Create Animals Json
    [Arguments]     ${animalsData}
    ${jsonString}     Convert JSON To String    ${animalsData}
    Create File    ${OUTPUT_DIR}/animals.json    ${jsonString}    UTF-8

Get Animals Count
    ${animals}    Get Element Count    ${tableRow}
    [Return]    ${animals}

Download Animals in Page
    ${animals}    Get Animals Count
    ${animalList}    Create List
    FOR    ${index}    IN RANGE    ${animals}
        Set Focus To Element    ${tableRow}:nth-child(${index+1})
        ${hasNotSound}    Run Keyword and Return Status     Page Should Not Contain Element    ${tableRow}:nth-child(${index+1})${audioButton}
        Continue For Loop If    ${hasNotSound}
        ${animalData}    Download Animal Data    ${tableRow}:nth-child(${index+1})
        Append To List    ${animalList}    ${animalData}
    END
    [Return]   ${animalList}

Download Animal Data
    [Arguments]     ${locator}
    Set Focus To Element    ${locator} td:nth-child(1)
    ${number}    Get Text    ${locator} td:nth-child(1)
    ${class}    Get Text    ${locator} td:nth-child(2)
    ${family}    Get Text    ${locator} td:nth-child(3)
    ${gender}    Get Text    ${locator} td:nth-child(4)
    ${species}    Get Text    ${locator} td:nth-child(5)
    ${popularName}    Get Text    ${locator} td:nth-child(6)
    Get Individual Data
    ${animal}    Create Dictionary    number=${number}    class=${class}    family=${family}    gender=${gender}    species=${species}    popularName=${popularName}
    [Return]    ${animal}

Click on Individual Data
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator} td:nth-child(1)
    Click Element    ${locator} td:nth-child(1)

Individual Data Popup Must Be Opened
    Wait Until Element Is Visible    ${individualDataPopup}

Close Individual Data Popup
    Wait Until Element Is Visible    ${individualDataPopupCloseButton}
    Click Element    ${individualDataPopupCloseButton}

Get Individual Data
    Click on Individual Data
    Individual Data Popup Must Be Opened
    Close Individual Data Popup

    
    