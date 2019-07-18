# Invoke Oracle BI Report using PowerShell
  - We will utilize ExternalReportWSSService webservice
  - The high level steps are as below:
    - Read username, password, wsdl end point from loginDetails.json file
    - Construct the SOAP request Header with authentication values
    - Invoke BI Report
    - Decode the base64 response and generate CSV file
