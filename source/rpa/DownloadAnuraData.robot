*** Settings ***
Library     SeleniumLibrary
Resource    ../support/common.robot
Resource    ../support/fnjv.robot
Test Setup    Start Browser
Test Teardown    Close All Browsers

*** Tasks ***
Download Anura Data
    Navigate to FNJV Site
    Click On Sound Collection Link
    Wait Until Spinner is Not Visible
    Expand Search Block
    On Phylum Selector, Select Chordata Option
    On Class Selector, Select Amphibia Option
    On Order Selector, Select Anura Option
    Click On Search Button
    Download All Records in Search Results
    