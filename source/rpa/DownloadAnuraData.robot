*** Settings ***
Library     SeleniumLibrary
Resource    ../support/common.robot
Resource    ../support/fnjv.robot
Test Setup    Start Browser
Test Teardown    Close All Browsers

*** Test Cases ***
Download Anura Data
    Navigate to FNJV Site
    Click On Sound Collection Link
    Wait Until Spinner is Not Visible
    Expand Search Block
    