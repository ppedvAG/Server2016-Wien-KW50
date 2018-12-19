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

#manuelles Starten des Dedupjobs 
Start-DedupJob -Type Optimization -Volume E:
#prüfen des Fortschrit wenn keine Antwort kommt ist sie fertig
Get-DedupJob 

#prüfen ob die Topologie fähig ist für Storage Replica 
Test-SRTopology -SourceComputerName Server3 -SourceVolumeName f: -SourceLogVolumeName g: -DestinationComputerName Server4 -DestinationVolumeName f: -DestinationLogVolumeName g: -DurationInMinutes 0 -ResultPath c:\temp 
#Storage Replica konfigurieren
New-SRPartnership -SourceComputerName Server3 -SourceRGName rg03 -SourceVolumeName f: -SourceLogVolumeName g: -DestinationComputerName Server4 -DestinationRGName rg04 -DestinationVolumeName f: -DestinationLogVolumeName g:

#StorageSpacesDirect aktivieren
Enable-ClusterStorageSpacesDirect -cimSession s2dcluster

#Nano1 ohne Domain Join
New-NanoServerImage -DeploymentType Guest -Edition Datacenter -MediaPath D: -BasePath .\Base -TargetPath .\Nano1.vhdx -ComputerName Nano1 -Package Microsoft-NanoServer-Guest-Package