# Terraform Project 2

This project shows how to use **one Terraform module** to create two AWS resources:

* An S3 bucket
* An EC2 instance

The main `main.tf` file lives in the root, and it calls a module that sits in a `modules` folder.

This is your first step from “everything in one file” to “reusable modules”.

---

## Folder structure

Example layout:

```text
project-2/
  main.tf                # root, calls the module
  modules/
    main.tf              # module: S3 + EC2
    variables.tf         # module input variables
```

You run Terraform from the **root** folder (where `main.tf` is).

---

## What the module does

Inside `modules/main.tf`:

```hcl
resource "aws_s3_bucket" "newsbucket" { 
  bucket = var.bucket_name
}

resource "aws_instance" "aninastance" {
  instance_type = var.instance_type
  ami           = var.ami_id
}
```

So the module:

* Creates an S3 bucket using `var.bucket_name`
* Creates an EC2 instance using `var.instance_type` and `var.ami_id`

Both values are passed in from the root module.

---

## Module variables

Inside `modules/variables.tf`:

```hcl
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}
```

These variables are required.
They must be passed from the root `main.tf`.

---

## Root configuration

In the root `main.tf`:

```hcl
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source        = "./modules"
  bucket_name   = "my-unique-bucket-name-12345x"
  instance_type = "t2.micro"
  ami_id        = "ami-0fa3fe0fa7920f68e"
}
```

What this does:

* Sets the AWS region to `us-east-1`
* Calls the module in `./modules`
* Passes values for `bucket_name`, `instance_type` and `ami_id`

### Important note about the bucket name

`bucket_name` must be **globally unique** across all AWS accounts.
If you get an error about the bucket name being taken, change it to something more unique, for example:

```hcl
bucket_name = "hannah-terraform-bucket-2025-xyz"
```

---

## How to run this project

From the root folder where `main.tf` is:

```bash
terraform init
terraform plan
terraform apply
```

---

## Clean up

To avoid charges, destroy the resources when you are done:

```bash
terraform destroy
```

This will remove the S3 bucket and the EC2 instance that were created by this project.

---

## What this project teaches

* How to use a module from a root `main.tf` file
* How to pass variables from root to module
* How one module can manage multiple resources
* The idea that modules are reusable building blocks

Once you understand this pattern, you can apply it to larger projects with many modules.

N/B the variable inputs are hardcoded here, but check next lab for a different more suitable way of handling this. 
