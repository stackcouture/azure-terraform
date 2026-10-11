# Terraform Azure Provider Configuration

## Overview

This project configures the **HashiCorp AzureRM Terraform provider** to manage Microsoft Azure resources using Infrastructure as Code (IaC).

The configuration specifies the required Terraform version, pins the AzureRM provider to the `5.x` minor-version series, and enables the provider's required `features` block.

## Prerequisites

Before getting started, ensure you have the following installed and configured:

- [Terraform](https://developer.hashicorp.com/terraform/install) version `1.2.0` or later.
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) for Azure authentication.
- A Microsoft Azure account.
- An Azure subscription with the necessary permissions to create and manage resources.

## Project Structure

```text
01-terraform-providers-version/
├── main.tf
├── provider.tf
├── .terraform.lock.hcl
└── providers-version.md
```

- `provider.tf` — Defines the Terraform and AzureRM provider configuration.
- `.terraform.lock.hcl` — Records the selected provider version and checksums for consistent installations.
- `providers-version.md` — Documents the project and setup instructions.

## Terraform Configuration

The following configuration can be saved as `provider.tf`.

```hcl
terraform {
  required_version = ">= 1.2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
```

### Configuration Breakdown

| Configuration | Description |
|---|---|
| `required_version = ">= 1.2.0"` | Requires Terraform 1.2.0 or later. |
| `source = "hashicorp/azurerm"` | Specifies the official AzureRM provider. |
| `version = "~> 5.0"` | Allows AzureRM versions `5.0.0` and later within the `5.x` major-version series. |
| `provider "azurerm"` | Configures the provider used to interact with Azure. |
| `features {}` | Required provider configuration block for AzureRM. |

## Authentication

Terraform needs valid Azure credentials to manage Azure resources.

### Option 1: Authenticate using Azure CLI

Sign in interactively:

```bash
az login
```

If your organization requires MFA and the regular login flow does not complete authentication, try:

```bash
az login --use-device-code
```

Complete the browser sign-in and MFA prompts.

Verify your active subscription:

```bash
az account list --output table
az account show --output table
```

If you have access to multiple subscriptions, select the intended subscription:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

**Note:** Authentication alone does not grant subscription access. Your identity must have the necessary Azure permissions.

### Option 2: Service Principal Authentication

For automation and CI/CD pipelines, consider using a Microsoft Entra service principal or workload identity federation. Store credentials in a secure secret manager or use federated credentials rather than hardcoding secrets in Terraform files.

## Initialize Terraform

Download the required provider and initialize the working directory:

```bash
terraform init
```

## Validate the Configuration

Check the Terraform configuration for syntax and structural errors:

```bash
terraform validate
```

Format the configuration:

```bash
terraform fmt -recursive
```

Review the Terraform configuration and provider requirements:

```bash
terraform version
terraform providers
```

## Deployment Workflow

When you are ready to define Azure resources, use the following workflow:

```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

Review the execution plan before applying changes.

To remove resources created by this configuration, use:

```bash
terraform destroy
```

**Important:** The current `main.tf` configures only the provider. It does not define any Azure resources, so `terraform plan` will normally report that there are no changes to make. Add resource definitions before expecting Terraform to provision infrastructure.

## Troubleshooting

### Azure authentication failure

If you encounter an MFA-related error such as `AADSTS50076`, complete the required MFA authentication:

```bash
az login --use-device-code
```

If necessary, sign in to the intended tenant:

```bash
az login --use-device-code --tenant "<TENANT_ID>"
```

### No subscriptions found

Check whether your identity has access to an Azure subscription:

```bash
az account list --all --output table
```

If no subscription is available, verify your tenant and account permissions or obtain the appropriate subscription access.

### Provider initialization errors

Reinitialize Terraform:

```bash
terraform init -upgrade
```

Use this command when you intentionally want Terraform to reconsider provider versions permitted by your constraints. Commit the resulting `.terraform.lock.hcl` changes when appropriate.

## Best Practices

- Commit `.terraform.lock.hcl` to version control.
- Never commit credentials, client secrets, or sensitive `.tfvars` files.
- Use least-privilege Azure RBAC permissions.
- Prefer workload identity federation for supported CI/CD environments.
- Review `terraform plan` before applying infrastructure changes.
- Pin provider versions deliberately and test upgrades before adopting them.

## References

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AzureRM Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Authentication](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli)
- [Azure Availability Zones](https://learn.microsoft.com/en-us/azure/availability-zones/az-overview)

## License

Specify the license applicable to this project before publishing or distributing it.