*** Settings ***
Library     Browser    auto_closing_level=SUITE
Library     load_env.py
Library     CryptoLibrary    variable_decryption=True

*** Variables ***
${Username}    crypt:k0h2VyrrAxxkFSf/+ZhB1E7y01Pw7uPbGdwTKeyTXiGxh+kT2Y5NTGE6up2quep7dqRYWXD5G14=
${Password}    crypt:15X9iPcvr/aU9Ngc807vtZU2JWmqSrbun6LaIqzngUp+3WoYmVtCn00ddBH2Nnb6634UJao=
${Message}     Tämä on testiviesti
${Weight}      75
${Sleep}       8

*** Test Cases ***
Testaa Oma Lomake
    New Browser    chromium    headless=No
    New Page       ${BASE_URL}/src/pages/apitest.html

    Type Text      id=feeling     ${Username}
    Type Secret    id=password    ${Password}
    Type Text      id=note        ${Message}
    Fill Text      id=weight      ${Weight}
    Fill Text      id=sleep       ${Sleep}

    Set Input Files    input[type="file"]    ./examplefile.txt
    Check Checkbox     id=my-checkbox
    Click              input[type="radio"][value="ok"]

    Sleep    2s
