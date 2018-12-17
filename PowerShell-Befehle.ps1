#umbennen von pcs mit powershell
Rename-Computer -NewName Server1 -Restart

#registrieren eines Geräts beim DNS
ipconfig /registerdns

#lokalen dns cache löschen
Clear-DnsClientCache      

#dns server
Clear-DnsServerCache     

#domain join und rename
Add-Computer -DomainName ppedv.test -NewName Server2 -Restart -Credential ppedv\Administrator