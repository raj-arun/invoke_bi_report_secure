# Invoke Oracle BI Report using PowerShell
  - We will utilize **ExternalReportWSSService** webservice
  - The high level steps are as below:
    - Read username, password, wsdl end point from loginDetails.json file
    - Construct the SOAP request Header with authentication values
    - Invoke BI Report
    - Decode the base64 response and generate CSV file

# How to Run
  - Place all the files into a folder and run the invoke_report.ps1 script
  - Make sure you have PowerShell 5.1.1 and above. Check the version off Powershell using the command:
  - *Get-Host | Select-Object Version*
