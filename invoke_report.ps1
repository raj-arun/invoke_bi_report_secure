#Read user name , password and wsdl endpoint
$loginData = Get-Content -Raw -Path 'loginDetails.json' | ConvertFrom-Json

#Encrypt the username and password
$pair="$($loginData.biuser):$($loginData.bipwd)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$basicAuthValue = "Basic $encodedCreds"

#Create the header for Web Service Request
[Net.ServicePointManager]::SecurityProtocol = "tls12"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('SOAPAction','')
$headers.Add('Authorization',$basicAuthValue)

#Invoke BI Report
Invoke-WebRequest $loginData.wsdl `
-Method Post -ContentType "application/soap+xml;charset=utf-8" `
-Headers $headers -InFile EPM_Account_Hierarchy.xml -OutFile output.xml

#Generate CSV File
[xml]$report = Get-Content output.xml
$EncodedString = $report.Envelope.Body.runReportResponse.runReportReturn.reportBytes
$DecodedString = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncodedString))
$DecodedString | Out-File "temp.txt"
Import-CSV "temp.txt" -delimiter "," | Export-CSV EPM_Account_Metadata.csv -NoType
