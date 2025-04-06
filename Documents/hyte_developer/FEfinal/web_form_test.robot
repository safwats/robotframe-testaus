*** Settings ***
Library     Browser    auto_closing_level=SUITE
Resource    Keywords.robot  

*** Test Cases ***
Test Web Form Elements
    [Documentation]    Testaa Web form-esimerkkisivun eri elementtien toimintaa
    # Avaa selain ja sivu
    New Browser    chromium    headless=No  
    New Page       https://www.selenium.dev/selenium/web/web-form.html 
    Get Title      ==    Web form
    
    # Testaa tekstikentät
    Type Text      [name="my-text"]        ${Username}    delay=0.1 s 
    Type Secret    [name="my-password"]    $Password      delay=0.1 s
    Type Text      [name="my-textarea"]    ${Message}     delay=0.1 s
    
    # Testaa dropdown-valikko (select)
    Select Options By    [name="my-select"]    text    Two
    
    # Testaa datalist
    Fill Text      [name="my-datalist"]    San Francisco
    
    # Testaa liukusäädin (range)
    Fill Text      [name="my-range"]    7
    
    # Testaa valintaruudut (checkboxit)
    Check Checkbox    [id="my-check-1"]
    Check Checkbox    [id="my-check-2"]
    
    # Lähetä lomake
    Click With Options    button    delay=2 s
    Get Text       id=message    ==    Received!
    
    # Testi on valmis
    Sleep          1s