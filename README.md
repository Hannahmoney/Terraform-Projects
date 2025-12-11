# Terraform AWS Labs

This repo contains multiple small Terraform projects.  
Each folder is an independent Terraform project.

Projects:

1. `Terraform create, declare assign variables`  
2. `Terraform Module-Intro`  
3. `Terraform Module - II`  
4. Terraform - create multiple modules`  
5. `Terraform create resources from lucid chart`  

To run any project:

```bash
cd "<project-folder>"
terraform init
terraform plan
terraform apply
```

## Clean up

To avoid charges, destroy the resources when you are done:

```bash
terraform destroy
```