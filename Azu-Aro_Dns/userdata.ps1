write-host "running init script"
if(!(test-path -Path "c:\temp"))
  {    
    New-Item -ItemType directory -Path "C:\temp"
    write-host "created temp directory"
  }
$client = new-object System.Net.WebClient
$client.DownloadFile("https://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.0.0-x64.msi","c:\temp\puppet.msi")
cd "c:\temp"