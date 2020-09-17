# WindowsServer
 Opdracht 3de jaarsvak 'Windows Server'

 # Windows server Examen Periode 3

 ## Opdracht:

 U bent IT-Consultant en krijgt de vraag om een proof of concept te maken van onderstaande
 Windows omgeving. Je moet deze demonstreren aan de opdrachtgever.

 Deze omgeving zal bestaan uit het volgende.

 1. De opdrachtgever wenst een redundante oplossing voor zijn infrastructuur. Dit zal vooral
     gebaseerd zijn op de volgende onderdelen.Je gaat er voor zorgen dat de opdrachtgever een
     oplossing zal krijgen voor de volgende onderdelen.
        a. Mailoplossing (Exchange).
        b. Automatische uitrollen van clients en servers (SCCM – MDT).
        c. SharePoint als intranet oplossing.
        d. De nodige SQL servers voor bovenstaande onderdelen.

 U krijgt dus volgende situatie

 **1. Domeincontroller**
 
     a. OS: Windows 2019
     
     b. NAAM domain controller 1 ➔ WIN-DC1-3DE
     
     c. IP instellingen WIN-DC1-3DE
        i. 1 NIC op NAT
        ii. 1 NIC op intern netwerk met volgende IP configuratie
        
     1. IP: 192.168.1 00 .1 0
     2. SN: 255.255.255.
 
 
 **2. SQL server**
 
     a. OS: Windows 2016 of 2019
     b. Naam SQL Server ➔ WIN-SQL-3DE
     c. Versie SQL versie 2017
     d. IP instellingen SQL server
        i. 1 NIC op intern netwerk
           1. IP: 192.168.1 00. 20
           2. SN: 255.255.255.
           3. DG: 192.168.1 00 .1 0
           
           
 **3. Exchange server**
     a. OS: Windows 2016 of 2019
     b. Naam Exchange Server ➔ WIN-EXC-3DE
     c. Versie Exchange: 2016 (afhankelijk van uw keuze van Windows Server)
     d. IP instellingen Exchange
        i. 1 NIC op intern netwerk
           1. IP: 192.168.100. 30
           2. SN: 255.255.255.
           3. DG: 192.168.100. 10


 **4. Deployment server**
     a. OS: Windows 2016 of 2019
     b. Naam ➔ WIN-SCCM-3DE
     c. Versie SCCM: 2016
     d. IP instellingen Deployment
        i. 1 NIC op intern netwerk
           1. IP: 192.168.100. 40
           2. SN: 255.255.255.
           3. DG: 192.168.1 00. 10
           
           
 **5. SharePoint server**
     a. OS Windows 2016 of 2019
     b. Naam SQL Server ➔ WIN-SHP-3DE
     c. Versie SharePoint: 2016
     d. IP instellingen Exchange
        i. 1 NIC op intern netwerk
           1. IP: 192.168.100. 50
           2. SN: 255.255.255.
           3. DG: 192.168.100. 10
           
           
 **6. Windows Cliënt**
     a. OS: Windows 10
     b. Naam client ➔ WIN-CLT1-3DE
     c. IP: via DHCP van de DC
        i. Scoop instellen
           1. Naam scoop: HoGent3DE
 ii. Range van de DHCP
 1. 192.168.100.160 tot 192.168.100.
 iii. Zorg dat de client ook de DGW en de DNS servers meekrijgt binnen zijn DHCP
 aanvraag.
     d. Software nodig om te mailen (Office – Thunderbird - ....)
     
     
 **7. Bijkomende specificaties**
     a. Domeinnaam voor deze opstelling ➔ **uw voornaam.periode**
        i. Voorbeeld ➔ **dirk.periode**
     b. Configureer op uw DC 1 de routerfaciliteiten zodat uw intern netwerk via de DC1 op
        het internet kan.
     c. Zorg ook dan DNS op alle servers wordt ingesteld op 192.168.100.
     
     
 **8. Opdracht specifiek servers**
     a. Automatiseer alles via **Powershell**.
        i. Dit betekent dat u een oplossing zoekt via scripting om uw servers en clients
           te installeren via een powershell script.
        ii. Nummer deze scripts in de volgorde die nodig zijn om de installatie te
            voltooien.
     b. Maak geen gebruik van **VAGRANT**
     c. Exchange server




 ```
 i. Moet zo geconfigureerd worden dat het mogelijk is om een mail te sturen
 naar dirk.thijs@pcprof.be.
 d. Deployment server:
 i. Alles scripten en gebruik maken van MDT.
 ii. Moet mogelijk zijn om een Windows Cliënt te installeren via een image.
 iii. Moet mogelijk zijn om Adobe reader te deployen op een Windows toestel via
 een package (msi of iets dergelijks)
 iv. Beheer uw updates via de deployment omgeving.
 e. SharePoint server
 i. Installatie en configuratie voor een intranet site.
 ii. Automatiseer deze via PowerShell.
 iii. Niet toegankelijk van buiten het netwerk.
 iv. Gebruik AD security groepen om de intranet site te kunnen gebruiken.
 ```
 **9. Evaluatie**
     a. Als documentatie zorgt u voor een volledige installatiehandleiding van alle
        verschillende servers en clients. Schrijf ook de bijhorende informatie uit. Zoals DHCP,
        DNS. Wat doen deze in uw netwerk enz.
     b. Uw portfolio moet dienen om aan een latere opdrachtgever te bezorgen. Ga er
        vanuit dat deze opdrachtgever geen IT specialist is.
     c. Deze bezorgd uw portfolio via mail voor 15 augustus 2019 voor 23:59 uur aan
        dirk.thijs@hogent.be
     d. Plaats uw portfolio ook op Chamilo onder opdracht 3de periode
