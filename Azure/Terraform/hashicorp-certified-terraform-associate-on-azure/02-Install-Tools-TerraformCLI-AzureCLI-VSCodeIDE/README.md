---
title: Install Terraform, Azure CLI and VSCode Editor
description: Install all the tools required for learning Terraform on Azure Cloud
---

## Step-01: Introduction
- Install [Terraform CLI](https://www.terraform.io/downloads.html) or [Terraform Releases](https://releases.hashicorp.com/terraform/)
- Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Install [VS Code Editor](https://code.visualstudio.com/download)
- Install [Git Client](https://git-scm.com/downloads)

## Step-02: MACOS: Terraform Install
- [Download Terraform MAC](https://www.terraform.io/downloads.html)
- [Install CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Unzip the package
```t
# Copy binary zip file to a folder
mkdir /Users/<YOUR-USER>/Documents/terraform-install
COPY Package to "terraform-install" folder

# Unzip
unzip <PACKAGE-NAME>
unzip terraform_0.15.4_darwin_amd64.zip

# Copy terraform binary to /usr/local/bin
echo $PATH
mv terraform /usr/local/bin

# Verify Version
terraform version

# To Uninstall Terraform (NOT REQUIRED)
rm -rf /usr/local/bin/terraform
``` 

## Step-03: MACOS: IDE for Terraform - VS Code Editor
- [Microsoft Visual Studio Code Editor](https://code.visualstudio.com/download)
- [Hashicorp Terraform Plugin for VS Code](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- Configure [Course Github Repository](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure) using VS Code Editor


## Step-04: MACOS: Install Azure CLI
- [Azure CLI Install](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Install Azure CLI - MAC](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos)
```t
# Install XCode
brew update 
xcode-select --install
Observation: Verify images for reference in "image-reference" folder

# Sample Error (Without Xcode if we try az cli install it will through this error)
Error: python@3.8: the bottle needs the Apple Command Line Tools to be installed.
  You can install them, if desired, with:
    xcode-select --install


# AZ CLI Current Version (if installed)
az --version

# Install Azure CLI (if not installed)
brew update 
brew install azure-cli

# Upgrade az cli version
az --version
brew upgrade azure-cli 
[or]
az upgrade
az --version
```

## Step-05: Terraform - Authenticating using the Azure CLI
- [Azure Provider: Authenticating using the Azure CLI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)
```t
# Azure CLI Login
az login

# List Subscriptions
az account list

# Set Specific Subscription (if we have multiple subscriptions)
az account set --subscription="SUBSCRIPTION_ID"
```

## Step-06: Install Git Client
- [Download Git Client](https://git-scm.com/downloads)
- This is required when we are working with `Terraform Modules`

## Step-07: WindowsOS: Terraform & Azure CLI Install
### Step-07-01: Install Git Client
- [Download Git Client](https://git-scm.com/downloads)
- This is required when we are working with `Terraform Modules`

### Step-07-02: Install Azure CLI
- Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
- `Step-05:Terraform - Authenticating using the Azure CLI` is going to be same for WindowsOS too. 
```t
# Azure CLI Login
az login

# List Subscriptions
az account list

# Set Specific Subscription (if we have multiple subscriptions)
az account set --subscription="SUBSCRIPTION_ID"
```
