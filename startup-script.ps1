<powershell>
mkdir c:\temp

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe -OutFile c:\temp\Git-2.23.0-64-bit.exe
c:\temp\Git-2.23.0-64-bit.exe /silent

Invoke-WebRequest https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.17.0.msi -UseBasicParsing -OutFile c:\temp\mysql-installer-community-8.0.17.0.msi

# Start-Process msiexec.exe -Wait -ArgumentList '/I C:\temp\mysql-installer-community-8.0.17.0.msi /quiet'

# Add-Type -AssemblyName System.IO.Compression.FileSystem
# [System.IO.Compression.ZipFile]::ExtractToDirectory("c:\temp\mysql-8.0.17-winx64.zip", "c:\temp\")
# Rename-Item c:\temp\mysql-8.0.17-winx64 c:\temp\mysql

</powershell>
