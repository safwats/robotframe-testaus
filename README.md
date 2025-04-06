API Kirjautumistesti
Tämä testi tarkistaa sovelluksen kirjautumistoiminnallisuuden käyttäen Robot Framework RequestsLibrary -kirjastoa ja sovelluksen API-rajapintaa.
Testin kuvaus
Testi lähettää HTTP POST -pyynnön sovelluksen kirjautumisrajapintaan käyttäen Keywords.robot-tiedostossa määriteltyjä tunnuksia. Testi tarkistaa, että kirjautuminen onnistuu ja vastaus sisältää odotetut tiedot, kuten käyttäjän token-arvon.
Vaatimukset

Robot Framework (vähintään versio 4.0)
RequestsLibrary (pip install robotframework-requests)
Toimiva backend-palvelin osoitteessa http://127.0.0.1:3000
Keywords.robot-tiedosto, joka sisältää muuttujat ${Username} ja ${Password}

Asennus

Varmista, että Robot Framework ja tarvittavat kirjastot on asennettu:
Copypip install robotframework
pip install robotframework-requests

Varmista, että backend-palvelin on käynnissä osoitteessa http://127.0.0.1:3000

Testin suorittaminen
Suorita testi komennolla:
Copyrobot login_test.robot
Jos haluat määritellä loki- ja raporttitiedostojen nimet erikseen:
Copyrobot --log login_log.html --report login_report.html login_test.robot
Testin rakenne

Kirjautuminen Onnistuu API-rajapinnan Kautta: Testitapaus, joka testaa onnistunutta kirjautumista

Testitiedoston sisältö
Testitiedosto login_test.robot sisältää:

Settings: Määrittelee käytettävät kirjastot ja resurssit
Variables: Määrittelee API-osoitteen ja kirjautumisrajapinnan polun
Test Cases: Määrittelee suoritettavat testitapaukset
Keywords: Määrittelee testeissä käytettävät avainsanat

Huomioitavaa

Testi olettaa, että Keywords.robot-tiedosto sisältää muuttujat ${Username} ja ${Password}
Testi olettaa, että backend-palvelin on käynnissä osoitteessa http://127.0.0.1:3000
Testi olettaa, että kirjautumisrajapinnan polku on /api/auth/login
Testi olettaa, että onnistunut kirjautuminen palauttaa JSON-vastauksen, joka sisältää kentät token ja user





![healtydiary merkintä](https://github.com/user-attachments/assets/fc04ed07-c4de-4fba-9cab-a91f3f9697f2)

![TEHTÄVÄ 5](https://github.com/user-attachments/assets/24d90991-04fd-4c57-a3e6-7d6a9cffafda)

![tehtävä 6](https://github.com/user-attachments/assets/3c2ba2cf-f3e1-452c-852a-a6e1aa6d90d5)



