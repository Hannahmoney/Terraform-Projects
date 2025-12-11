# Terraform Infrastructure Project

Before starting, open your terminal and move into the project root:

```
cd /path/to/your/terraform/root
```

Below is the architecture diagram representing the full VPC, subnets, NAT gateway, ALB, Auto Scaling Group and S3 bucket used in this Terraform project:


This repository contains a multi stage AWS infrastructure stack written in Terraform.
It mirrors the CloudFormation version from the companion repo here:

**CloudFormation version:**
[https://github.com/Hannahmoney/AWS-Infra-set-up-with-Cloud-Formation.git](https://github.com/Hannahmoney/AWS-Infra-set-up-with-Cloud-Formation.git)

---

## Stages in this project

1. VPC with public and private subnets, IGW, route tables, NAT
2. Security groups for EC2 and ALB
3. IAM role and instance profile
4. Application Load Balancer and target group
5. Launch template and Auto Scaling Group
6. S3 bucket

Each stage is separated into modules for simplicity and reuse.

---

## Important difference from the CloudFormation version

The CloudFormation template includes VPC endpoints for S3, SSM, SSMMessages and EC2Messages.

The Terraform version does **not** include these endpoints because the infrastructure uses a NAT gateway instead, and NAT already allows private EC2 instances to reach AWS services.

---

## Quick start

### 1. Set your variables

Edit `terraform.tfvars` to set your own CIDRs, instance type, AMI ID and bucket name.

You can also pass the EC2 keypair name from the CLI:

```
terraform apply -var key_name=my_keypair
```

The keypair must already exist in your AWS account.

---

### 2. Initialise Terraform

```
terraform init
```

### 3. Preview changes

```
terraform plan
```

### 4. Deploy resources

```
terraform apply
```

---

## Project structure

```
root/
  main.tf
  variables.tf
  outputs.tf
  terraform.tfvars

modules/
  vpc/
  scg/
  iam/
  alb/
  compute/
  s3/
```

Each module contains its own `main.tf`, `variables.tf` and `outputs.tf`.

---

## Simple example of module wiring

```hcl
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnets_ids
  alb_sg_id          = module.scg.alb_sg_id
  alb_name           = var.alb_name
}
```

Outputs from one module become inputs to another using the pattern:

```
module.<module_name>.<output_name>
```

---

## State management

This project uses **local Terraform state**.
The `.gitignore` file ensures that Terraform state files are never pushed to GitHub.

Remote state (S3 + DynamoDB) can be added later if you want team-ready infrastructure.

---


## Notes

* Never commit private keys or AWS credentials.
* Only the public key is referenced in Terraform.
* Values in `terraform.tfvars` can be changed anytime depending on your setup or region.

---

