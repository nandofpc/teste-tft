#Instalar o AD
Add-WindowsFeature AD-Domain-Services
Install-WindowsFeature AD-Domain-Services
Install-WindowsFeature -Name DNS -IncludeManagementTools
