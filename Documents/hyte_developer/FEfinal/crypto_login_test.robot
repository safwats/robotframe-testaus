*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     ./crypto_utils.py
Resource    Keywords.robot

*** Variables ***
${API_URL}    http://127.0.0.1:3000
${LOGIN_ENDPOINT}    /api/auth/login

*** Test Cases ***
Kirjautuminen Onnistuu Kryptatuilla Tunnuksilla
    # Generoi avain
    ${key}=    Generate Key
    Set Suite Variable    ${key}
    Log    Generoitu salausavain: ${key}
    
    # Kryptaa käyttäjätunnus ja salasana
    ${encrypted_username}=    Encrypt Text    ${Username}    ${key}
    ${encrypted_password}=    Encrypt Text    ${Password}    ${key}
    
    # Lokiin kryptatut tunnukset (vain testikäyttöön)
    Log    Kryptattu käyttäjätunnus: ${encrypted_username}
    Log    Kryptattu salasana: ${encrypted_password}
    
    # Dekryptaa tunnukset
    ${decrypted_username}=    Decrypt Text    ${encrypted_username}    ${key}
    ${decrypted_password}=    Decrypt Text    ${encrypted_password}    ${key}
    
    # Vertaa alkuperäisiin
    Should Be Equal    ${decrypted_username}    ${Username}
    Should Be Equal    ${decrypted_password}    ${Password}
    
    # Luo kirjautumisdatan
    ${auth_data}=    Create Dictionary    username=${decrypted_username}    password=${decrypted_password}
    
    # Kirjaudu
    ${response}=    POST    url=${API_URL}${LOGIN_ENDPOINT}    json=${auth_data}    expected_status=anything
    
    # Tarkista vastaus
    Run Keyword If    ${response.status_code} == 200    Kirjautuminen Onnistui    ${response}
    ...    ELSE    Kirjautuminen Epäonnistui    ${response}

*** Keywords ***
Kirjautuminen Onnistui
    [Arguments]    ${response}
    Log    Kirjautuminen onnistui!
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    token
    Dictionary Should Contain Key    ${json}    user
    ${token}=    Set Variable    ${json}[token]
    Set Suite Variable    ${token}

Kirjautuminen Epäonnistui
    [Arguments]    ${response}
    Log    Kirjautuminen epäonnistui. Status koodi: ${response.status_code}
    Log    Virheilmoitus: ${response.text}
    Fail    Kirjautuminen epäonnistui API-rajapinnan kautta