## Azure CLI Installation on Windows

This guide explains how to install and configure the **Azure CLI (az CLI)** on a Windows machine.

Azure CLI is a command-line tool used to manage Azure resources and authenticate with Microsoft Azure.

---
### Prerequisites

* Windows 10 or Windows 11
* Internet connection
* Administrator access
* A Microsoft Azure account

---
### 1. Download Azure CLI

Download the official **Azure CLI Windows MSI installer** from Microsoft:

[Install Azure CLI on Windows — Microsoft Learn](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?utm_source=chatgpt.com)

Download the appropriate **64-bit MSI installer** for a standard modern Windows machine.

---
### 2. Install Azure CLI

After downloading the `.msi` installer:

```text
Azure CLI MSI
     ↓
Run Installer
     ↓
Accept License Agreement
     ↓
Install
     ↓
Finish
```

The default installation location is typically:

```text
C:\Program Files\Microsoft SDKs\Azure\CLI2\
```

The Azure CLI executable is normally available through:

```text
C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\
```

---
### 3. Restart PowerShell or VS Code

After installation, close any existing:

* PowerShell windows
* Command Prompt windows
* Visual Studio Code windows

Then reopen PowerShell or VS Code.

This is important because the new Azure CLI installation must be loaded into the updated `PATH`.

---
### 4. Verify Azure CLI Installation

Open PowerShell and run:

```powershell
az version
```

You should see output similar to:

```text
{
  "azure-cli": "2.x.x",
  "azure-cli-core": "2.x.x"
}
```

You can also run:

```powershell
az --version
```

---
### 5. Verify Azure CLI Location

Run:

```powershell
where.exe az
```

Expected output:

```text
C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd
```

This confirms that Windows can locate the Azure CLI executable.

---
### 6. Check the Azure CLI PATH

Run:

```powershell
$env:Path -split ';' | Select-String "Azure"
```

You should see a path similar to:

```text
C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin
```

If Azure CLI is installed but the `az` command is not recognized, completely close and reopen VS Code or PowerShell.

---
## Azure CLI Authentication

Once Azure CLI is installed, authenticate with Azure.

### 7. Login to Azure

Run:

```powershell
az login
```

A browser window will open.

Sign in using your Microsoft Entra ID account.

After successful authentication, Azure CLI will display the subscriptions associated with your account.

---
### 8. Login Using Device Code

If normal browser authentication does not work or you are using a terminal environment, use:

```powershell
az login --use-device-code
```

Azure CLI will display a URL and a device code.

Example:

```text
To sign in, use a web browser to open the page:

https://microsoft.com/devicelogin

and enter the code:

XXXXXXXXX
```

Open the displayed URL, enter the code, and complete authentication.

If your organization requires **Multi-Factor Authentication (MFA)**, complete the MFA challenge.

---
## Verify Azure Authentication

### 9. Display the Current Account

Run:

```powershell
az account show -o table
```

Example:

```text
Name                  CloudName    SubscriptionId
--------------------  -----------  ------------------------------------
Dev Subscription      AzureCloud   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Important fields:

```text
Name
SubscriptionId
TenantId
```

---
### 10. List All Available Subscriptions

Run:

```powershell
az account list -o table
```

Example:

```text
Name                    CloudName    SubscriptionId
----------------------  -----------  ------------------------------------
Development             AzureCloud   11111111-1111-1111-1111-111111111111
Testing                 AzureCloud   22222222-2222-2222-2222-222222222222
Production              AzureCloud   33333333-3333-3333-3333-333333333333
```

---
### 11. Select a Specific Subscription

If you have multiple subscriptions, select the subscription you want to work with:

```powershell
az account set --subscription "11111111-1111-1111-1111-111111111111"
```

Or using the subscription name:

```powershell
az account set --subscription "Development"
```

Verify:

```powershell
az account show -o table
```

---
## Test Azure CLI

### 12. Create a Test Resource Group

To verify that your account has permission to create Azure resources:

```powershell
az group create `
  --name rg-cli-test `
  --location centralindia
```

Or use a single line:

```powershell
az group create --name rg-cli-test --location centralindia
```

Expected output will contain:

```json
{
  "location": "centralindia",
  "name": "rg-cli-test",
  "provisioningState": "Succeeded"
}
```

---
### 13. Delete the Test Resource Group

After testing, remove the resource group:

```powershell
az group delete --name rg-cli-test --yes
```

This prevents unnecessary Azure resources from remaining in your subscription.

---
## Troubleshooting

### `az` is not recognized

If you receive:

```text
az : The term 'az' is not recognized as the name of a cmdlet
```

Check whether Azure CLI is installed:

```powershell
Test-Path "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"
```

If the result is:

```text
True
```

Azure CLI is installed, but your current terminal probably has an outdated `PATH`.

### Solution

1. Close PowerShell.
2. Close Visual Studio Code completely.
3. Reopen Visual Studio Code.
4. Open a new PowerShell terminal.
5. Run:

```powershell
az version
```

---
### Check Azure CLI executable directly

If Azure CLI exists but `az` is not recognized, run:

```powershell
& "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" version
```

If this works, the installation is fine and the problem is related to the Windows `PATH`.

---
## Azure CLI + Terraform

Azure CLI is particularly useful for local Terraform development.

The authentication flow is:

```text
Windows Machine
      │
      ├── Azure CLI
      │       │
      │       └── az login
      │
      ▼
Microsoft Entra ID
      │
      ▼
Azure Subscription
      │
      ▼
Terraform
      │
      ▼
AzureRM Provider
      │
      ▼
Azure Resource Manager
      │
      ▼
Azure Resources
```

Terraform provider configuration:

```hcl
provider "azurerm" {
  features {}
}
```

After authenticating with:

```powershell
az login
```

Terraform can use the Azure authentication context for local development.

---
## Useful Azure CLI Commands

### Check Azure CLI version

```powershell
az version
```

### Login

```powershell
az login
```

### Login with device code

```powershell
az login --use-device-code
```

### Show current account

```powershell
az account show
```

### Show current account as a table

```powershell
az account show -o table
```

### List subscriptions

```powershell
az account list -o table
```

### Select subscription

```powershell
az account set --subscription "<SUBSCRIPTION_ID>"
```

### List resource groups

```powershell
az group list -o table
```

### Create resource group

```powershell
az group create --name rg-devops-dev --location centralindia
```

### Delete resource group

```powershell
az group delete --name rg-devops-dev --yes
```

### Logout

```powershell
az logout
```

---
## Final Setup

After completing this guide, your Windows machine should have:

```text
Windows Machine
│
├── Terraform
│     └── terraform.exe
│
├── Azure CLI
│     └── az.cmd
│
└── Visual Studio Code
      │
      └── PowerShell
```

Authentication:

```text
az login
    │
    ▼
Microsoft Entra ID
    │
    ▼
Azure Subscription
```

Terraform:

```text
Terraform
    │
    ▼
AzureRM Provider
    │
    ▼
Azure Resource Manager
    │
    ▼
Azure Subscription
    │
    ▼
Resource Groups / VNets / AKS / VMs / etc.
```

At this point, the machine is ready for **Azure + Terraform infrastructure development**.
