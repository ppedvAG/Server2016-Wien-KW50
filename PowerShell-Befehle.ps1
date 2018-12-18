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

#Installieren von der DateiServer Rolle auf Server3
Install-WindowsFeature -Name FS-FileServer -ComputerName Server3 -IncludeManagementTools

#Verbinden einer PowerShell Remote Session zu Server 2
Enter-PSSession -ComputerName Server2