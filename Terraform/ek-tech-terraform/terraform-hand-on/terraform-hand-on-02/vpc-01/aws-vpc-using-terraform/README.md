# Design a 3 Tier AWS VPC with NAT Gateways using Terraform

## Introduction
- Understand about Terraform Modules
- Create VPC using `Terraform Modules`
- Define `Input Variables` for VPC module and reference them in VPC Terraform Module
- Define `local values` and reference them in VPC Terraform Module
- Create `terraform.tfvars` to load variable values by default from this file
- Create `vpc.auto.tfvars` to load variable values by default from this file related to a VPC 
- Define `Output Values` for VPC

## vpc-module 
### How to make a decision of using the public Registry module?
1. Understand about [Terraform Registry and Modules](https://registry.terraform.io/)
2. We are going to use a [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) from Terraform Public Registry
3. Review the download rate for that module
4. Review the latest versions and [release history](https://github.com/terraform-aws-modules/terraform-aws-vpc/releases) of that module
5. Review our feature needs when using that module and ensure if our need is satisfied use the module else use the standard terraform resource definition appraoch. 
6. Review module inputs, outputs and dependencies too. 

## Version Constraints in Terraform with Modules
- [Terraform Version Constraints](https://www.terraform.io/docs/language/expressions/version-constraints.html)
- For modules locking to the exact version is recommended to ensure there will not be any major breakages in production
- For modules maintained within your organization, specifying version ranges may be appropriate if semantic versioning is used consistently or if there is a well-defined release process that avoids unwanted updates.

