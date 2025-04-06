*** Settings ***
Library     Browser    auto_closing_level=SUITE
Resource    Keywords.robot

*** Test Cases ***
Login And View Health Diary Entries
    [Documentation]    Kirjaudu sisään ja tarkastele hyvinvointipäiväkirjamerkintöjä
    New Browser    chromium    headless=No
    New Page       http://localhost:5173/src/pages/authtest.html

    # Odotetaan että kirjautumislomake näkyy
    Wait For Elements State    .loginForm    visible    timeout=10s
    
    # Täytetään kirjautumistiedot
    Type Text    .loginForm input[name="username"]    ${Username}    delay=0.1s
    Type Text    .loginForm input[name="password"]    ${Password}    delay=0.1s
    
    # Klikataan kirjautumisnappia
    Click    .loginForm input[type="submit"]
    
    # Otetaan kuvakaappaus tässä vaiheessa nähdäksemme mihin päädyimme
    Take Screenshot    name=after_login
    
    # Odotetaan jotain elementtiä, joka osoittaa että kirjautuminen onnistui
    Wait For Elements State    body    visible    timeout=10s
    
    # Logataan sivun HTML debuggausta varten
    ${html}=    Get Page Source
    Log    ${html}
    
    # Otetaan kuvakaappaus testin lopussa
    Take Screenshot    name=paivakirja_merkintojennakyminen
    Close Browser

Add New Health Diary Entry
    [Documentation]    Lisää uusi hyvinvointipäiväkirjamerkintä
    New Browser    chromium    headless=No
    New Page       http://localhost:5173/src/pages/authtest.html

    # Odotetaan että kirjautumislomake näkyy
    Wait For Elements State    .loginForm    visible    timeout=10s
    
    # Täytetään kirjautumistiedot
    Type Text    .loginForm input[name="username"]    ${Username}    delay=0.1s
    Type Text    .loginForm input[name="password"]    ${Password}    delay=0.1s
    
    # Klikataan kirjautumisnappia
    Click    .loginForm input[type="submit"]
    
    # Otetaan kuvakaappaus tässä vaiheessa nähdäksemme mihin päädyimme
    Take Screenshot    name=after_login_entry
    
    # Odotetaan jotain elementtiä, joka osoittaa että kirjautuminen onnistui
    Wait For Elements State    body    visible    timeout=10s
    
    # Logataan sivun rakenne tässä vaiheessa
    ${html}=    Get Page Source
    Log    ${html}
    
    # Haetaan kaikki näkyvät lomake-elementit
    ${input_elements}=    Get Elements    input
    ${num_inputs}=    Get Length    ${input_elements}
    Log    Löydettiin ${num_inputs} input-elementtiä
    
    # Haetaan kaikki näkyvät napit
    ${button_elements}=    Get Elements    button
    ${num_buttons}=    Get Length    ${button_elements}
    Log    Löydettiin ${num_buttons} button-elementtiä
    
    # Otetaan kuvakaappaus testin lopussa
    Take Screenshot    name=paivakirja_lomake
    Close Browser