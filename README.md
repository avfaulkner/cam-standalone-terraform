# cam-standalone-terraform

***Currently WIP***

Stacks for deploying CAM Standalone:
- AWS
- Azure
- GCP

Builds basic network infra and single instance. 

Future: will add DC server to connect.

## Requirements
### Tooling
- Terraform >= 0.12.26

## Usage
__~~**Update the terraform.tfvars file with your desired variables**__~~

Initialize the environment

```
terraform init
```

Planning

```
terraform plan
```

Apply

```
terraform apply
```

**Notes**
- GCP: Compute Engine API must be enabled in the console prior
to running the Terraform script. 

