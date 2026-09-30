## Terraform Manual Installation on Windows

This guide explains how to manually install Terraform on a Windows machine without using Chocolatey.

### Prerequisites

* Windows 10 or Windows 11
* Internet access
* Administrator access if modifying the system PATH

---
### 1. Download Terraform

Download the **Windows AMD64 Terraform ZIP** from the official HashiCorp Terraform releases page.

Choose the appropriate Windows AMD64 ZIP package.

---
### 2. Extract Terraform

Extract the downloaded ZIP file.

You will find:

```text
terraform.exe
```

---
### 3. Create a Permanent Terraform Directory

Create the following directory:

```text
C:\Tools\Terraform
```

Move the extracted `terraform.exe` into this directory.

Your final directory structure should look like:

```text
C:\Tools\Terraform\
└── terraform.exe
```

---
### 4. Add Terraform to the Windows PATH

Terraform needs to be added to the Windows `PATH` so that you can run the `terraform` command from any PowerShell or Command Prompt window.

#### Open Environment Variables

Go to:

```text
Windows Search
    ↓
Environment Variables
    ↓
Edit the system environment variables
    ↓
Environment Variables
    ↓
Path
    ↓
Edit
    ↓
New
```

Add:

```text
C:\Tools\Terraform
```

Click **OK** to save all changes.

---
### 5. Open a New PowerShell Window

Close your existing PowerShell or Command Prompt window.

Open a **new PowerShell** window so Windows reloads the updated PATH.

---
### 6. Verify Terraform Installation

Run:

```powershell
terraform version
```

You should see output similar to:

```text
Terraform v1.x.x
on windows_amd64
```

The exact Terraform version will depend on the version you downloaded.

---
### 7. Verify the Terraform Executable Location

You can also verify that Windows is finding the correct Terraform executable:

```powershell
where.exe terraform
```

Expected output:

```text
C:\Tools\Terraform\terraform.exe
```

---
### 8. Test Terraform

Run:

```powershell
terraform -help
```

If Terraform displays its available commands, the installation is working correctly.

---
### Installation Summary

The final setup should look like:

```text
Windows
│
├── C:\Tools\Terraform\
│       └── terraform.exe
│
└── PATH
        └── C:\Tools\Terraform
```

You can now run Terraform commands from any PowerShell or Command Prompt window:

```powershell
terraform version
terraform init
terraform validate
terraform plan
terraform apply
```

