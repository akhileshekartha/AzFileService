# Azure File Share Integration for Dynamics 365 Business Central

This repository demonstrates how to integrate **Azure File Share** with **Dynamics 365 Business Central** (BC) using the latest AL language capabilities (BC 23.3 release). 

## Features
- **Read/Write Operations**: Seamlessly read and write files in Azure File Share.
- **File Management**: Move or delete files within the share.
  
## Prerequisites
- **Azure Storage Account** with File Share.
- **SAS Token** to authenticate requests.
- BC 23.3 or later.

## Setup
1. Create an Azure Storage Account and File Share.
2. Set up BC to connect with the Azure File Share using the SAS Token.
3. Deploy the AL code to enable file operations.

## Example Usage
Use AL to interact with files:
```al
codeunit 50100 "AKH Azure File Service"
// Reading a file
procedure ReadFileFromShare(FilePath: Text; var FileText: Text)
