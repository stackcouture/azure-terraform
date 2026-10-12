# Azure Terraform Remote State Bootstrap

## Overview

This project bootstraps the Azure resources required to store Terraform state remotely using Azure Blob Storage.

It provisions an Azure Resource Group, an Azure Storage Account, and a private Blob container. The Storage Account is configured with Geo-Redundant Storage (GRS), HTTPS-only traffic, TLS 1.2, disabled shared-key authentication, and disabled public network access.

## Architecture

```text
Azure Subscription
└── Resource Group: rg-tfstate-dev
    └── Storage Account: sttfstate<random-suffix>
        └── Blob Container: tfstate
            └── Terraform State Files
```

## Resources Created

| Resource | Terraform Resource | Description |
|---|---|---|
| Resource Group | `azurerm_resource_group.tfstate` | Hosts the Terraform state storage resources |
| Storage Account | `azurerm_storage_account.tfstate` | Provides Azure Blob Storage |
| Blob Container | `azurerm_storage_container.tfstate` | Stores Terraform state files |
| Random Suffix | `random_string.suffix` | Generates a unique suffix for the Storage Account name |

## Configuration

The following values are used for the bootstrap deployment.

| Variable | Value |
|---|---|
| `rg_name` | `rg-tfstate-dev` |
| `rg_location` | `Central India` |
| Storage Account name prefix | `sttfstate` |
| Storage Account performance | Standard |
| Storage Account kind | StorageV2 |
| Replication | GRS |
| Minimum TLS version | TLS 1.2 |
| HTTPS-only traffic | Enabled |
| Public network access | Disabled |
| Shared-key authentication | Disabled |
| Blob container | `tfstate` |
| Container access | Private |

The Storage Account name is generated dynamically using an eight-character random suffix. For example, it may look like `sttfstatea1b2c3d4`.

## Prerequisites

Install and configure the following tools:

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure subscription
- An Azure identity with the required permissions to create resource groups and storage accounts

## Project Structure

```text
terraform-bootstrap/
├── bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
└── bootstrap.md
```

Adjust the directory structure if your actual repository differs.

## Input Variables

Define the following variables in `variables.tf`:

```hcl
variable "rg_name" {
  description = "Name of the resource group for Terraform state"
  type        = string
}

variable "rg_location" {
  description = "Azure region for the Terraform state resources"
  type        = string
}
```

Configure the values in `terraform.tfvars`:

```hcl
rg_name     = "rg-tfstate-dev"
rg_location = "Central India"
```

## Deployment Steps

### 1. Authenticate with Azure

```bash
az login
az account list --output table
az account set --subscription "<SUBSCRIPTION_ID>"
```

Ensure the intended Azure subscription is selected.

### 2. Initialize Terraform

Run the following commands from the directory containing the root Terraform configuration:

```bash
terraform init
```

### 3. Validate the configuration

```bash
terraform fmt -recursive
terraform validate
```

### 4. Review the execution plan

```bash
terraform plan
```

Review the resources and configuration before proceeding.

### 5. Apply the configuration

```bash
terraform apply
```

Confirm the operation when prompted.

### 6. Verify the resources

```bash
az group show \
  --name rg-tfstate-dev \
  --output table

az storage account list \
  --resource-group rg-tfstate-dev \
  --output table
```

## Security Considerations

- **Private container:** Anonymous public access to Blob container data is disabled.
- **HTTPS-only:** Insecure HTTP traffic is disabled.
- **TLS 1.2:** Minimum TLS version is configured.
- **Shared-key authentication:** Disabled to encourage Microsoft Entra ID-based access.
- **Public network access:** Disabled to restrict access through the public endpoint.
- **GRS replication:** Data is replicated to a secondary Azure region for additional resilience.
- **Least privilege:** Grant only the permissions required to users and automation identities.

### Important Networking and Authentication Notes

Because public network access is disabled, clients must have an appropriate private connectivity path, such as a configured private endpoint and private DNS, to access the Storage Account.

Terraform identities also require appropriate Azure control-plane permissions to provision resources and data-plane permissions to access Blob Storage. For remote state access, configure the required Blob data permissions and Microsoft Entra ID authentication.

## Important: Configuring the Terraform Backend

This project creates the resources needed for a remote backend, but creating the Storage Account and container does not automatically configure Terraform to use them.

A separate Terraform configuration can use the AzureRM backend:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "<ACTUAL_STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  }
}
```

Replace the placeholder with the actual Storage Account name generated during bootstrap. Configure any required backend authentication and private networking before running `terraform init`.

### Bootstrap State Management

The bootstrap configuration itself initially stores its state locally unless a backend is configured separately. Protect the local state file and back it up securely.

For a production-ready setup, consider managing the bootstrap state separately from the application infrastructure state, and plan the migration carefully if you later move the bootstrap state to Azure Blob Storage.

## Cleanup

To remove the resources managed by this configuration, run:

```bash
terraform destroy
```

**Warning:** Destroying the Storage Account removes the remote state storage infrastructure. Do not destroy it while other Terraform configurations depend on it. Back up required state files and migrate dependent backends before removing the storage resources.

## References

- [Azure Storage Account documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Terraform AzureRM Storage Account resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Terraform AzureRM Storage Container resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
- [Terraform AzureRM backend](https://developer.hashicorp.com/terraform/language/backend/azurerm)
