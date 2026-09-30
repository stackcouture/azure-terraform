# Git Installation and Configuration on Windows

This guide provides a step-by-step procedure for installing **Git for Windows**, configuring Git, and validating the installation.

Git is a distributed version control system widely used for source-code management, collaboration, CI/CD, and Infrastructure as Code workflows.

---
## Table of Contents

* [Prerequisites](#prerequisites)
* [Download Git](#1-download-git)
* [Install Git](#2-install-git)
* [Verify Installation](#3-verify-installation)
* [Verify Git Bash](#4-verify-git-bash)
* [Configure Git Identity](#5-configure-git-identity)
* [Configure Default Branch](#6-configure-default-branch)
* [Configure Credential Manager](#7-configure-git-credential-manager)
* [Create a Test Repository](#8-create-a-test-repository)
* [Create the First Commit](#9-create-the-first-commit)
* [Verify Git Configuration](#10-verify-git-configuration)
* [Git and GitHub Workflow](#11-git-and-github-workflow)
* [Common Git Commands](#12-common-git-commands)
* [Recommended DevOps Workstation](#13-recommended-devops-workstation)

---
## Prerequisites

Before installing Git, ensure that you have:

* Windows 10 or Windows 11
* Internet connectivity
* Administrator access
* Visual Studio Code installed (recommended)

---
### 1. Download Git

Download **Git for Windows** from the official Git website:

[Git for Windows](https://git-scm.com/install/windows?utm_source=chatgpt.com)

Download the latest Windows installer.

The downloaded file will typically have a name similar to:

```text
Git-x.x.x-64-bit.exe
```

---
### 2. Install Git

Run the downloaded installer.

The Git installation wizard will guide you through several configuration options.

For a standard DevOps workstation, the default options are generally appropriate.

---
#### 2.1 Select the Installation Directory

The default installation directory is typically:

```text
C:\Program Files\Git
```

Keep the default location unless you have a specific requirement to change it.

Click:

```text
Next
```

---
#### 2.2 Select Components

The default components are sufficient for most users.

Recommended components include:

```text
Git Bash Here
Git GUI Here
Git LFS
Associate .git* configuration files
Associate .sh files
```

Continue with:

```text
Next
```

---
#### 2.3 Select the Default Editor

When prompted to select the default Git editor, you can select:

```text
Visual Studio Code
```

if VS Code is your primary development environment.

Alternatively, you can use Vim or another editor.

For a DevOps workstation using VS Code:

```text
Visual Studio Code
```

is recommended.

---
#### 2.4 Configure PATH

When Git asks how it should be added to the system PATH, select:

```text
Git from the command line and also from 3rd-party software
```

This allows Git commands to work from:

* PowerShell
* Command Prompt
* Visual Studio Code Terminal
* Git Bash
* Other development tools

---
#### 2.5 Select SSH Client

Select:

```text
Use bundled OpenSSH
```

This provides the OpenSSH client included with Git for Windows.

---
#### 2.6 Configure HTTPS

Select:

```text
Use the OpenSSL library
```

This provides HTTPS support for Git operations.

---
#### 2.7 Configure Line Endings

For a standard Windows development environment, use:

```text
Checkout Windows-style, commit Unix-style line endings
```

This helps maintain compatibility between Windows development machines and Linux-based CI/CD environments.

---
#### 2.8 Install Git

Review the selected options and click:

```text
Install
```

Wait for the installation to complete.

Then click:

```text
Finish
```

---
## 3. Verify Installation

Close any existing PowerShell or Command Prompt windows.

Open a **new PowerShell** window and run:

```powershell
git --version
```

Expected output:

```text
git version 2.x.x.windows.1
```

The exact version depends on the version installed.

---
### 3.1 Verify Git Executable Location

Run:

```powershell
where.exe git
```

Expected output:

```text
C:\Program Files\Git\cmd\git.exe
```

This confirms that Git is available through the Windows PATH.

---
## 4. Verify Git Bash

Git for Windows includes **Git Bash**, which provides a Unix-like shell environment on Windows.

Open:

```text
Start Menu
    ↓
Git Bash
```

Run:

```bash
git --version
```

Expected output:

```text
git version 2.x.x.windows.1
```

Git Bash is useful for DevOps engineers who regularly work with Linux commands and shell scripting.

---
## 5. Configure Git Identity

Git uses your configured name and email when creating commits.

### 5.1 Configure Username

Run:

```powershell
git config --global user.name "Your Name"
```

Example:

```powershell
git config --global user.name "Naveen"
```

---
### 5.2 Configure Email

Run:

```powershell
git config --global user.email "your-email@example.com"
```

Use the email address associated with your GitHub account if you want GitHub to associate your commits with your account.

---
### 5.3 Verify Identity

Run:

```powershell
git config --global user.name
```

and:

```powershell
git config --global user.email
```

---
## 6. Configure Default Branch

Modern Git repositories commonly use `main` as the default branch.

Configure Git to use `main` when creating new repositories:

```powershell
git config --global init.defaultBranch main
```

Verify:

```powershell
git config --global init.defaultBranch
```

Expected output:

```text
main
```

---
## 7. Configure Git Credential Manager

Git for Windows includes **Git Credential Manager (GCM)**.

Check the configured credential helper:

```powershell
git config --global credential.helper
```

A typical configuration is:

```text
manager
```

Git Credential Manager allows Git to securely manage authentication with supported Git hosting platforms such as GitHub.

---
## 8. Create a Test Repository

Create a directory for testing:

```powershell
mkdir C:\git-test
```

Navigate to it:

```powershell
cd C:\git-test
```

Initialize a Git repository:

```powershell
git init
```

Expected output:

```text
Initialized empty Git repository in C:/git-test/.git/
```

---
### 8.1 Check Repository Status

Run:

```powershell
git status
```

Expected output will indicate that the repository has no commits yet.

---
## 9. Create the First Commit

Create a README file:

```powershell
"Hello Git" | Out-File README.md
```

Check the repository:

```powershell
git status
```

You should see:

```text
Untracked files:
  README.md
```

---
### 9.1 Stage the File

Run:

```powershell
git add README.md
```

Verify:

```powershell
git status
```

The file should now appear under:

```text
Changes to be committed
```

---
### 9.2 Create the Commit

Run:

```powershell
git commit -m "Initial commit"
```

Expected result:

```text
[main xxxxxxx] Initial commit
```

---
### 9.3 View Commit History

Run:

```powershell
git log --oneline
```

Example:

```text
a1b2c3d Initial commit
```

---
## 10. Verify Git Configuration

Display all global Git configuration:

```powershell
git config --global --list
```

Example:

```text
user.name=Your Name
user.email=your-email@example.com
init.defaultbranch=main
credential.helper=manager
```

---
## 11. Git and GitHub Workflow

Git is normally used together with a remote Git hosting platform such as GitHub.

A typical DevOps workflow is:

```text
Developer
    │
    ▼
Local Git Repository
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Build
    ├── Test
    ├── Security Scan
    ├── Terraform Plan
    └── Terraform Apply
    │
    ▼
Azure
```

---
### Clone an Existing Repository

Use:

```powershell
git clone https://github.com/<USERNAME>/<REPOSITORY>.git
```

Example:

```powershell
git clone https://github.com/example/devops-project.git
```

Navigate into the repository:

```powershell
cd devops-project
```

---
### Check Remote Repository

Run:

```powershell
git remote -v
```

Example:

```text
origin  https://github.com/example/devops-project.git (fetch)
origin  https://github.com/example/devops-project.git (push)
```

---
## 12. Common Git Commands

### Repository Operations

```powershell
git init
git clone <repository-url>
git status
```

### Staging and Commits

```powershell
git add .
git add <file>
git commit -m "Commit message"
```

### Branches

```powershell
git branch
git branch <branch-name>
git switch <branch-name>
git switch -c <branch-name>
```

### Remote Operations

```powershell
git remote -v
git fetch
git pull
git push
```

### History

```powershell
git log
git log --oneline
git show
```

---
## 13. Recommended DevOps Workstation

After completing the installation, your Windows DevOps workstation can be structured as:

```text
Windows Machine
│
├── Visual Studio Code
│
├── Git
│   ├── Git CLI
│   └── Git Bash
│
├── Terraform
│   └── terraform.exe
│
└── Azure CLI
    └── az.cmd
```

The tools work together as follows:

```text
                    Developer
                        │
                        ▼
                 Visual Studio Code
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
         Git        Terraform      Azure CLI
          │             │             │
          ▼             │             ▼
       GitHub            │        Azure Authentication
          │              │             │
          ▼              │             ▼
   GitHub Actions        │       Azure Subscription
          │              │
          └──────────────┤
                         ▼
                  AzureRM Provider
                         │
                         ▼
                       Azure
```

---
## Installation Verification Checklist

Use the following commands to verify the complete setup:

```powershell
git --version
```

```powershell
terraform version
```

```powershell
az version
```

```powershell
az account show -o table
```

```powershell
code --version
```

All tools should return their installed versions or account information successfully.

---
### Summary

The Git installation process is:

```text
Download Git for Windows
        ↓
Install Git
        ↓
Add Git to PATH
        ↓
Verify git --version
        ↓
Configure user.name
        ↓
Configure user.email
        ↓
Configure main as default branch
        ↓
Configure Git Credential Manager
        ↓
Initialize/Test Repository
        ↓
Connect to GitHub
```

Git is now ready for use with **GitHub, GitHub Actions, Terraform, Azure CLI, and Azure infrastructure projects**.
