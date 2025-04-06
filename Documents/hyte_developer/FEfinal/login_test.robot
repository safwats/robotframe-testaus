*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    Keywords.robot    # Tämä sisältää ${Username} ja ${Password} muuttujat

*** Variables ***
${API_URL}    http://127.0.0.1:3000    # Backend-palvelimen osoite
${LOGIN_ENDPOINT}    /api/auth/login    # Kirjautumisrajapinnan polku

*** Test Cases ***
Kirjautuminen Onnistuu API-rajapinnan Kautta
    [Documentation]    Testaa kirjautumista API-rajapinnan kautta käyttäen Keywords.robot-tiedoston tunnuksia
    
    # Lokitetaan käytettävät tunnukset debuggausta varten
    Log    Kirjaudutaan tunnuksilla: käyttäjä=${Username}, salasana=${Password}
    
    # Luo kirjautumisdataa sisältävä sanakirja
    ${auth_data}=    Create Dictionary    username=${Username}    password=${Password}
    
    # Tehdään kirjautumispyyntö
    ${response}=    POST    url=${API_URL}${LOGIN_ENDPOINT}    json=${auth_data}    expected_status=anything
    
    # Lokitetaan vastaus debuggausta varten
    Log    Vastauksen status: ${response.status_code}
    Log    Vastauksen sisältö: ${response.text}
    
    # Tarkistetaan kirjautumisen onnistuminen
    Run Keyword If    ${response.status_code} == 200    Kirjautuminen Onnistui    ${response}
    ...    ELSE    Kirjautuminen Epäonnistui    ${response}

*** Keywords ***
Kirjautuminen Onnistui
    [Arguments]    ${response}
    [Documentation]    Käsittelee onnistuneen kirjautumisen
    Log    Kirjautuminen onnistui!
    
    # Varmistetaan että vastaus sisältää odotetut tiedot
    TRY
        ${json}=    Set Variable    ${response.json()}
        Log    JSON vastaus: ${json}
        
        # Tarkistetaan että vastaus sisältää tarvittavat avaimet
        Dictionary Should Contain Key    ${json}    token
        Dictionary Should Contain Key    ${json}    user
        
        # Tallennetaan token myöhempää käyttöä varten
        ${token}=    Set Variable    ${json}[token]
        Set Suite Variable    ${token}
    EXCEPT
        Log    Vastausta ei voitu käsitellä JSON-muodossa: ${response.text}
    END

Kirjautuminen Epäonnistui
    [Arguments]    ${response}
    [Documentation]    Käsittelee epäonnistuneen kirjautumisen
    Log    Kirjautuminen epäonnistui. Status koodi: ${response.status_code}
    Log    Virheilmoitus: ${response.text}
    
    # Tarkistetaan, onko vastaus JSON-muodossa
    TRY
        ${json}=    Set Variable    ${response.json()}
        Log    JSON virhevastaus: ${json}
    EXCEPT
        Log    Virhevastaus ei ole JSON-muodossa: ${response.text}
    END
    
    # Testitapaukselle on tärkeää, että se raportoi epäonnistumisen
    Fail    Kirjautuminen epäonnistui API-rajapinnan kautta