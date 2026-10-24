# Azure Virtual Machine Deployment using Terraform

## Overview

This project demonstrates how to provision an Azure Virtual Machine using Terraform with a modular and reusable infrastructure design.

The infrastructure is created step by step, starting with an Azure Resource Group, followed by networking components, security configurations, and the Virtual Machine.

## Architecture

The project includes the following Azure resources:

1. **Resource Group** — Organizes and manages the Azure resources.
2. **Virtual Network (VNet)** — Provides private network connectivity.
3. **Subnet** — Segments the virtual network for workload placement.
4. **Network Security Group (NSG)** — Controls inbound and outbound network traffic.
5. **Network Interface (NIC)** — Connects the Virtual Machine to the virtual network.
6. **Virtual Machine (VM)** — Provides the compute infrastructure.

## Technologies Used

- Microsoft Azure
- Terraform
- AzureRM Provider
- Azure CLI
- Terraform Modules

## Project Structure

```text
06-azure-virtual-machine/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── provider.tf
├── locals.tf
├── outputs.tf
└── modules/
    ├── rg/
    ├── vnet/
    ├── subnet/
    ├── nsg/
    └── vm/
```

*The directory structure above is the intended modular layout; adjust it to match the modules actually present in your repository.*

---
## Prerequisite: Generate SSH Keys for Azure Linux Virtual Machine

Before deploying the Azure Linux Virtual Machine, generate an SSH key pair. The public key will be configured on the VM, and the private key will be used to connect securely.

### 1. Create the SSH Keys Directory

```bash
cd terraform-manifests/
mkdir -p ssh-keys
cd ssh-keys
```

### 2. Generate the SSH Key Pair

```bash
ssh-keygen \
  -m PEM \
  -t rsa \
  -b 4096 \
  -C "azureuser@myserver" \
  -f terraform-azure.pem
```

When prompted, enter a passphrase or press Enter to leave it empty.

**Important:** If you configure a passphrase, you may need to enter it when using the private key to connect to the VM, unless an SSH agent has the key loaded.

### 3. Verify the Generated Files

```bash
ls -lrt
```

The command generates two files:

| File | Purpose |
|---|---|
| `terraform-azure.pem` | Private key used to authenticate to the VM |
| `terraform-azure.pem.pub` | Public key installed on the VM |

Rename the public key to `terraform-azure.pub` if required by your Terraform configuration:

```bash
mv terraform-azure.pem.pub terraform-azure.pub
```

### 4. Set Private Key Permissions

Restrict access to the private key:

```bash
chmod 400 terraform-azure.pem
```

SSH requires the private key to be protected from access by other users.

### 5. Security Notes

- Never share or commit the private key (`terraform-azure.pem`) to GitHub.
- Add `ssh-keys/` to your `.gitignore` file.
- Keep the private key secure and accessible only to the authorized user.
- Configure the public key path in your Terraform VM module.
- Store a secure backup of the private key if needed; it cannot be regenerated from the public key.

---
## Infrastructure Configuration

### Step 1: Resource Group

Creates the Azure Resource Group that will contain the infrastructure.

### Step 2: Virtual Network and Subnet

Creates the virtual network and subnet required for VM connectivity.

### Step 3: Network Security Group

Defines network security rules to control access to the VM.

### Step 4: Network Interface

Creates a network interface and connects it to the subnet, with the required security association.

### Step 5: Virtual Machine

Deploys the Azure Virtual Machine with the selected image, VM size, operating system, and network interface.

## Prerequisites

- An active Azure subscription.
- Azure CLI installed.
- Terraform installed.
- Appropriate permissions to create Azure resources.
- Azure CLI authentication completed.

Authenticate to Azure:

```bash
az login
az account show
```

## Deployment Steps

Run these commands from the project root directory.

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate the Configuration

```bash
terraform validate
```

### 3. Format the Terraform Files

```bash
terraform fmt -recursive
```

### 4. Review the Execution Plan

```bash
terraform plan
```

### 5. Deploy the Infrastructure

```bash
terraform apply
```

Review the execution plan and confirm the operation when prompted.

## Verify the Deployment

Verify the Resource Group:

```bash
az group show --name demo-rg
```

List the Virtual Machines in the Resource Group:

```bash
az vm list \
  --resource-group demo-rg \
  --output table
```

## Cleanup

To remove the infrastructure managed by this Terraform configuration:

```bash
terraform destroy
```

**Warning:** This can delete the Virtual Machine and other managed resources. Review the plan before confirming.

## Best Practices

- Use reusable Terraform modules.
- Manage resource names and configuration through input variables.
- Apply consistent tags for ownership and environment.
- Follow least-privilege access and secure network configuration.
- Store Terraform state securely using a remote backend for team environments.
- Avoid hardcoding credentials or committing secrets to Git.
- Review the execution plan before applying or destroying infrastructure.

## Goal

Build practical experience in provisioning Azure infrastructure using Terraform, from the initial Resource Group through networking, security, and Virtual Machine deployment.