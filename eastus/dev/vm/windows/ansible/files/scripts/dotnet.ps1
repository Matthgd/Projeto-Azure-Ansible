#.NET Framewotk 4.6
$netfw48 = "https://download.microsoft.com/download/1/4/A/14A6C422-0D3C-4811-A31F-5EF91A83C368/NDP46-KB3045560-Web.exe"
$dest = ".\ndp48.exe"
Invoke-WebRequest -Uri $netfw48 -OutFile $dest
Start-Process -Wait $dest -ArgumentList " /q /norestart"
Dism /online /enable-feature /featurename:IIS-ASPNET45 /all