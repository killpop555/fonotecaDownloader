*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}=    firefox

*** Keywords ***
Start Browser
    Open Browser    browser=${browser}