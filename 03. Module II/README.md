

# Terraform Project 4

This project improves the previous examples by introducing a cleaner **multi module structure**.
The root folder now contains its own `main.tf` and `variables.tf`, and each module has its own variable names.
Terraform prompts for all variable values during apply.

This setup is closer to real Terraform design where each module has clear inputs, and the root controls how values flow.

---

## Folder structure

```
version-3/
  main.tf            # root: provider + module calls
  variables.tf       # root: declares input variables
  modules/
    s3/
      main.tf        # S3 resources
      variables.tf   # S3 module inputs
    ec2/
      main.tf        # EC2 instance resource
      variables.tf   # EC2 module inputs
```

You run Terraform **only from the root folder**.

---

## Root main.tf

The root calls two modules.

```hcl
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source             = "../modules/s3"
  bucket_name_child  = var.bucket_name_root
  bucket_name_child2 = var.bucket_name_root2
}

module "ec2_instance" {
  source        = "../modules/ec2"
  instance_type = var.instance_type_root
  ami_id        = var.ami_id_root
}
```

Key ideas:

* The **root variable names** end with `_root`
* The **child module variable names** end with `_child`
* The root passes its values into the module by mapping:

```
child_variable_name = root_variable_name
```

Example:

```
bucket_name_child = var.bucket_name_root
```

This is a very common Terraform pattern.

---

## Root variables.tf

The root declares all the variables Terraform will ask for:

```hcl
variable "bucket_name_root" {
  type = string
}

variable "bucket_name_root2" {
  type = string
}

variable "instance_type_root" {
  type = string
}

variable "ami_id_root" {
  type = string
}
```

Terraform will prompt you for these values during apply.

---

## S3 module

Inside `modules/s3/main.tf`:

```hcl
resource "aws_s3_bucket" "newsbucket" {
  bucket = var.bucket_name_child
}

resource "aws_s3_bucket" "newsbucg" {
  bucket = var.bucket_name_child2
}
```

Module variable declarations (modules/s3/variables.tf):

```hcl
variable "bucket_name_child" {
  type = string
}

variable "bucket_name_child2" {
  type = string
}
```

The module does not care what the variable names were in the root.
It only cares about its own names.
The mapping happens in root `main.tf`.

---

## EC2 module

Inside `modules/ec2/main.tf`:

```hcl
resource "aws_instance" "aninastance" {
  instance_type = var.instance_type
  ami           = var.ami_id
}
```

Module variable declarations (modules/ec2/variables.tf):

```hcl
variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}
```

Again, the module variable names are independent from the root variable names.

---

## How variable naming works between root and modules

### Root variable:

```hcl
variable "instance_type_root"
```

### Mapped into module:

```hcl
instance_type = var.instance_type_root
```

### Module receives it as:

```hcl
variable "instance_type"
```

The function of each layer is:

* **Root** decides the values
* **Root main.tf** maps its variable names to the module’s variable names
* **Module** uses its own names internally

This flexibility lets you rename variables in the root without breaking the module.

---

## Running the project

From the root folder:

```
terraform init
terraform plan
terraform apply
```

Terraform will prompt for each variable:

```
var.bucket_name_root
  Enter a value:

var.bucket_name_root2
  Enter a value:

var.instance_type_root
  Enter a value:

var.ami_id_root
  Enter a value:
```

Enter your values and continue.

---

## Destroying the infrastructure

```
terraform destroy
```

Terraform will again ask for variable values unless you provide them with a tfvars file or CLI flags.

---

## What this version teaches

* How to split Terraform code into separate modules
* How root variables feed into module variables
* How to change variable names in the root without touching the module
* How to pass multiple variables into modules
* How Terraform prompts for values when no defaults or tfvars files exist

This is the first version where you truly manage **multiple modules** with a structured root configuration.

---


