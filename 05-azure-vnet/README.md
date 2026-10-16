# Azure Virtual Network (VNet) using Terraform

## Overview

This project provisions an Azure Virtual Network (VNet) and four subnets using Terraform. It follows a modular Infrastructure as Code (IaC) approach to create and manage Azure networking resources.

The infrastructure is designed for an HR development environment and uses separate subnets for web, application, database, and Azure Bastion workloads.

## Architecture

The project deploys the following Azure resources:

- Azure Resource Group
- Azure Virtual Network
- Web Subnet
- Application Subnet
- Database Subnet
- Bastion Subnet

```text
Azure Subscription
└── Resource Group: demo-rg
    └── Virtual Network: hr-dev-vnet
        ├── Web Subnet       10.1.1.0/24
        ├── App Subnet       10.1.11.0/24
        ├── Database Subnet  10.1.21.0/24
        └── Bastion Subnet   10.1.100.0/24
```

## Technologies Used

- Microsoft Azure
- Terraform
- Azure CLI
- Terraform AzureRM Provider
- Git and GitHub

## Prerequisites

Install and configure the following tools before deploying the infrastructure:

1. [Terraform](https://developer.hashicorp.com/terraform/install)
2. [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
3. An Azure subscription with permissions to create and manage networking resources.

Authenticate to Azure:

```bash
az login
```

Verify the active subscription:

```bash
az account show
```

If necessary, select the appropriate subscription:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

## Project Configuration

The project uses the following configuration values from `terraform.tfvars`.

| Variable | Value |
|---|---|
| `rg_name` | `demo-rg` |
| `location_name` | `India South Central` |
| `business_division` | `hr` |
| `environment` | `dev` |
| `vnet_name` | `vnet` |
| `vnet_address_space` | `10.1.0.0/16` |
| `web_subnet_name` | `websubnet` |
| `web_subnet_address` | `10.1.1.0/24` |
| `app_subnet_name` | `appsubnet` |
| `app_subnet_address` | `10.1.11.0/24` |
| `db_subnet_name` | `dbsubnet` |
| `db_subnet_address` | `10.1.21.0/24` |
| `bastion_subnet_name` | `bastionsubnet` |
| `bastion_subnet_address` | `10.1.100.0/24` |

The naming convention combines the business division, environment, and VNet name. For example, the VNet name is `hr-dev-vnet`.

## Network Address Design

| Component | CIDR | Purpose |
|---|---|---|
| VNet | `10.1.0.0/16` | Overall private network address space |
| Web Subnet | `10.1.1.0/24` | Web servers and frontend workloads |
| App Subnet | `10.1.11.0/24` | Application servers and backend workloads |
| Database Subnet | `10.1.21.0/24` | Database workloads |
| Bastion Subnet | `10.1.100.0/24` | Azure Bastion connectivity |

All four subnet address ranges fall within the VNet address space and do not overlap.

**Note:** Azure Bastion requires a dedicated subnet named `AzureBastionSubnet`. The supplied `bastionsubnet` name is not sufficient for deploying the Azure Bastion service itself. Rename the subnet and use the appropriate supported CIDR size if you intend to deploy the service.

## Deployment Steps

### 1. Clone the repository

```bash
git clone https://github.com/stackcouture/azure-terraform.git
cd azure-terraform/05-azure-vnet
```

### 2. Initialize Terraform

```bash
terraform init
```

This downloads the required Terraform providers and initializes the working directory.

### 3. Format the configuration

```bash
terraform fmt -recursive
```

### 4. Validate the configuration

```bash
terraform validate
```

This checks the Terraform configuration for syntax and structural errors.

### 5. Review the execution plan

```bash
terraform plan
```

Review the proposed changes before provisioning any Azure resources.

### 6. Deploy the infrastructure

```bash
terraform apply
```

Review the plan and enter `yes` when prompted.

For a saved execution plan:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### 7. Verify the deployed resources

Check the resource group:

```bash
az group show --name demo-rg
```

List VNets:

```bash
az network vnet list -o table
```

Inspect the VNet:

```bash
az network vnet show \
  --resource-group demo-rg \
  --name hr-dev-vnet
```

List the subnets:

```bash
az network vnet subnet list \
  --resource-group demo-rg \
  --vnet-name hr-dev-vnet \
  -o table
```

## Terraform State Management

Terraform state tracks the Azure resources managed by the current configuration.

Useful commands:

```bash
terraform state list
terraform state show <RESOURCE_ADDRESS>
terraform plan -refresh-only
```

Use a remote backend for team environments to support centralized state storage and state locking. Protect state files because they may contain sensitive information.

If an Azure resource is deleted outside Terraform, reconcile the state with the actual infrastructure before running another apply or destroy operation.

## Cleanup

To remove the infrastructure managed by Terraform, review the destruction plan first:

```bash
terraform plan -destroy
```

If the planned deletions are correct, execute:

```bash
terraform destroy
```

Review the confirmation prompt before proceeding.

**Warning:** Destroying the resource group may remove all resources inside it. Verify the scope of the plan before approving any destructive operation.

## Best Practices

- Use Terraform modules to separate resource group, VNet, subnet, and networking logic.
- Keep environment-specific values in variable files.
- Use remote state for shared or production environments.
- Never commit credentials, secrets, or Terraform state files to Git.
- Review every Terraform plan before applying changes.
- Use least-privilege Azure permissions.
- Use separate subnets and appropriate network security rules to control traffic between workloads.

## References

- [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
- [Azure Virtual Network documentation](https://learn.microsoft.com/azure/virtual-network/)
- [AzureRM Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI documentation](https://learn.microsoft.com/cli/azure/)

## Author

**StackCouture**

GitHub: [https://github.com/stackcouture/](https://github.com/stackcouture/)
Portfolio: [https://stackcouture.cloud/](https://stackcouture.cloud/)
