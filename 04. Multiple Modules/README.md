
# Terraform Project 4

This project introduces a more complete multi module structure.
All root Terraform files live inside a **root** folder, and there are four modules:

* VPC
* Security group
* EC2
* S3

Each module has its own `main.tf`, `variables.tf` and `outputs.tf`.
Outputs are used so one module can pass values to another.
For example, the VPC module outputs its VPC ID and subnet ID, and these values are used in the security group and EC2 modules.

---

## Folder structure

```
project-4/
  root/
    main.tf
    variables.tf
    terraform.tfvars
  modules/
    vpc/
      main.tf
      variables.tf
      outputs.tf
    sec-grp/
      main.tf
      variables.tf
      outputs.tf
    ec2/
      main.tf
      variables.tf
      outputs.tf
    s3/
      main.tf
      variables.tf
      outputs.tf
```

Run Terraform commands from the **root** folder.

---

## Outputs and why they matter

Modules cannot automatically see resources created by other modules.
To share values, each module exposes them in `outputs.tf`.

Example from the VPC module:

```hcl
output "thevpc_id" {
  value = aws_vpc.thevpc.id
}

output "publicsubnet_id" {
  value = aws_subnet.thepublicsubnet.id
}
```

Now the root module can call these values using:

```
module.vpc.thevpc_id
module.vpc.publicsubnet_id
```

These outputs are then passed into other modules, such as security groups and EC2.

---

## Root main.tf

The root folder connects all modules and passes the right values:

```hcl
module "vpc" {
  source                = "../modules/vpc"
  thevpc_cidr           = var.vpc_cidrz
  thepublicsubnet_cidr  = var.public_subnet_cidrz
}

module "sec-grp" {
  source    = "../modules/sec-grp"
  thevpc_id = module.vpc.thevpc_id
}

module "ec2" {
  source             = "../modules/ec2"
  ami_id             = var.ami_idz
  instance_type      = var.instance_typez
  thepublicsubnet_id = module.vpc.publicsubnet_id
  security_group_id  = module.sec-grp.secgrp_id
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_namez
}
```

---

## Variables and tfvars

Root variables are declared in `variables.tf`, and actual values are stored in `terraform.tfvars`.
Users can edit this file based on their preferred CIDRs, instance type, AMI ID or bucket name.

Example `terraform.tfvars`:

```
vpc_cidrz = "10.0.0.0/16"
public_subnet_cidrz = "10.0.0.0/24"

instance_typez = "t2.micro"
ami_idz        = "ami-0fa3fe0fa7920f68e"

bucket_namez   = "my-unique-bucket-example-2025"
```

The tfvars file makes it easy to reuse this project without editing the code.

---

## Running the project

From inside the **root** folder:

```
terraform init
terraform plan
terraform apply
```

When finished:

```
terraform destroy
```

---

## What this version teaches

* How to structure a Terraform project with multiple independent modules
* How `outputs.tf` makes values available between modules
* How the root module becomes the connection point for all components
* How to manage configuration cleanly with tfvars

This is the first version that feels like a real infrastructure layout, with proper inter-module communication.

---


