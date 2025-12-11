# Terraform Project 1

This folder contains three small exercises that introduce how Terraform handles variables.
They move step by step from hardcoded values to declared variables to external variable files.

## Folder structure

```
1. create-resource/
2. declare-variables/
3. assign-variables/
```

Each folder teaches one specific idea.

---

## 1. create resource

This folder shows the most basic way to create an AWS resource.
It creates an EC2 instance using hardcoded values directly inside `main.tf`.

Things shown here:

* The EC2 resource block
* Required arguments like `ami` and `instance_type`
* A simple tag to name the instance in the AWS console

Example pattern:

```hcl
resource "aws_instance" "examples" {
  ami           = var.ami  # Example AMI ID for Amazon Linux 2
  instance_type = var.instance_type

  tags = {
    Name = "TerraformExampleInstancez"
  }
}
```

There are no variables yet. Everything is fixed inside the resource block.

---

## 2. declare variables

This folder introduces a proper `variables.tf` file.

Here the variables are declared, and then main.tf references them using `var.<name>`.

Example variable declarations:

```hcl
variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}
```

Example usage inside the resource:

```hcl
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
}
```

Since there is no default value and no tfvars file yet, Terraform will ask for these values in the terminal during `terraform apply`.
You will see prompts like:

```
var.ami
  Enter a value:
```

This is the first step toward separating configuration from code.

---

## 3. assign variables

This folder shows how to assign values to variables from an external variable file.

A file named `prod.tfvars` and `terraform.tfvars` is used, but since the name is different you must specify it manually.

Example content:

```hcl
ami           = "ami-1234567890"
instance_type = "t3.micro"
```

You apply it like this:

```
terraform apply -var-file=prod.tfvars
```

You can also assign values directly from the terminal:

```
terraform apply -var "instance_type=t3.micro"
```

This approach is useful for multiple environments like dev, staging and prod.

---

## How to run any of the folders

Pick one of the three folders, then run:

```
cd <folder-name>
terraform init
terraform plan
terraform apply
```

Each folder is independent and has its own state.

---

