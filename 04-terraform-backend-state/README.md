# Azure Terraform Remote State Backend

## Overview

This project provisions Azure resources to store Terraform state remotely using Azure Blob Storage.

The bootstrap configuration creates an Azure Resource Group, a Storage Account, a private Blob container, and a Microsoft Entra ID role assignment. The remote backend allows Terraform to store infrastructure state centrally and supports collaboration across environments.

## Architecture

```text
Azure Subscription
└── Resource Group: rg-tfstate-dev
    └── Storage Account: sttfstategh3p8gh7
        └── Blob Container: tfstate
            └── dev.terraform.tfstate
```

## Resources Created

| Resource | Terraform Resource | Purpose |
|---|---|---|
| Resource Group | `azurerm_resource_group.tfstate` | Hosts the backend resources |
| Storage Account | `azurerm_storage_account.tfstate` | Provides Azure Blob Storage |
| Blob Container | `azurerm_storage_container.tfstate` | Stores the Terraform state blob |
| Role Assignment | `azurerm_role_assignment.tfstate_blob_access` | Grants Blob data access to the authenticated identity |
| Random String | `random_string.suffix` | Generates a suffix for a unique Storage Account name |

## Configuration

| Setting | Value |
|---|---|
| Resource Group | `rg-tfstate-dev` |
| Azure Region | Defined by `var.rg_location` |
| Storage Account | `sttfstategh3p8gh7` for the configured backend |
| Performance Tier | Standard |
| Account Kind | StorageV2 |
| Replication | GRS |
| Minimum TLS Version | TLS 1.2 |
| HTTPS-Only Traffic | Enabled |
| Public Blob Access | Disabled |
| Shared-Key Authentication | Disabled |
| Public Network Access | Enabled |
| Blob Container | `tfstate` |
| Container Access | Private |
| State File | `dev.terraform.tfstate` |
| Authentication | Microsoft Entra ID |

**Note:** The bootstrap configuration generates a Storage Account name dynamically using `random_string.suffix`. The backend configuration must use the actual Storage Account name created by that bootstrap deployment. The name `sttfstategh3p8gh7` is the configured backend name in this example.

## Prerequisites

- Terraform CLI version 1.2.0 or later.
- Azure CLI installed.
- An active Azure subscription.
- Permissions to create Azure resources and role assignments.
- An Azure identity with the required Blob data permissions.

## Project Structure

```text
04-terraform-backend-state/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── README.md
```

Adapt this structure to match the actual repository layout.

## Input Variables

Example `variables.tf`:

```hcl
variable "rg_name" {
  description = "Resource group name for Terraform state resources"
  type        = string
}

variable "rg_location" {
  description = "Azure region for Terraform state resources"
  type        = string
}
```

Example `terraform.tfvars`:

```hcl
rg_name     = "rg-tfstate-dev"
rg_location = "Central India"
```

## Bootstrap Deployment

The bootstrap configuration must be initialized with local state before the remote backend is available.

### 1. Authenticate with Azure

```bash
az login
az account show --output table
```

Select the intended subscription if necessary:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

### 2. Initialize the Bootstrap Project

From the bootstrap directory, run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Review the plan before applying changes.

### 3. Verify the Storage Account

```bash
az storage account show \
  --name sttfstategh3p8gh7 \
  --resource-group rg-tfstate-dev \
  --output table
```

Verify that the Storage Account and Blob container exist.

## Remote Backend Configuration

Configure the following backend in the Terraform project that will consume the remote state.

```hcl
terraform {
  required_version = ">= 1.2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "sttfstategh3p8gh7"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}
```

### Backend Settings Explained

| Argument | Description |
|---|---|
| `resource_group_name` | Resource group containing the Storage Account |
| `storage_account_name` | Existing Storage Account used for state storage |
| `container_name` | Blob container that stores state |
| `key` | Name of the Terraform state blob |
| `use_azuread_auth` | Uses Microsoft Entra ID authentication instead of shared-key authentication |

The backend block is separate from the AzureRM provider configuration. Terraform initializes the backend before provisioning resources through the provider.

## Initialize the Remote Backend

From the infrastructure project's root directory, run:

```bash
terraform init -reconfigure
```

Use `-reconfigure` when switching to or correcting the backend configuration without migrating an existing state.

If you need to preserve and migrate an existing state file, use the appropriate migration workflow instead.

After initialization:

```bash
terraform validate
terraform plan
```

## Authentication and RBAC

The backend uses Microsoft Entra ID authentication.

The identity running Terraform must have the **Storage Blob Data Contributor** role at the Storage Account or appropriate container scope.

The bootstrap configuration creates this assignment:

```hcl
data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "tfstate_blob_access" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
```

Azure role assignments can take several minutes to propagate.

An Azure subscription `Owner` role does not automatically grant Microsoft Entra ID-based Blob data access.

## Networking and Security

- Public network access is enabled for this development configuration.
- Anonymous public Blob access is disabled.
- Shared-key authentication is disabled.
- HTTPS-only traffic and TLS 1.2 are configured.
- The Blob container is private.
- Blob access is controlled using Microsoft Entra ID and Azure RBAC.

For a production environment, restrict public network access using appropriate firewall rules or disable it and configure a private endpoint with private DNS and network connectivity.

## Troubleshooting

### Key-based authentication is not permitted

Ensure the backend contains:

```hcl
use_azuread_auth = true
```

Confirm the authenticated identity has the required Blob data role.

### 403 AuthorizationFailure

Check:

1. The active Azure subscription and tenant.
2. The `Storage Blob Data Contributor` role assignment.
3. Storage Account networking and firewall rules.
4. Private endpoint and DNS connectivity if public network access is disabled.

### Storage Account name mismatch

The bootstrap configuration generates the Storage Account name dynamically. Use the actual name created by the bootstrap deployment in the backend configuration.

### Backend initialization fails

Check Blob access first:

```bash
az storage container list \
  --account-name sttfstategh3p8gh7 \
  --auth-mode login \
  --output table
```

If the request fails, resolve authentication, authorization, or networking before retrying `terraform init`.

## Cleanup

Do not destroy the backend while other Terraform projects depend on it.

Before removing the backend infrastructure:

1. Back up the Terraform state files.
2. Migrate dependent Terraform configurations away from the remote backend.
3. Verify that no other project uses the Storage Account or container.
4. Destroy the backend resources only when they are no longer required.

## References

- [Terraform AzureRM Backend](https://developer.hashicorp.com/terraform/language/backend/azurerm)
- [Azure Storage Account Documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Azure Storage Security](https://learn.microsoft.com/en-us/azure/storage/common/storage-security-guide)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
