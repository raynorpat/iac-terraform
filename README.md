# iac-terraform

## Instructions for Use

These instructions are for Windows. For Linux or MacOS, most of the same steps will apply, but some of the CLI syntax will be different.

- Clone the repository

- Install the Azure CLI for Windows.

- Download the Terraform executable from the Hashicorp website.

- Drop the executable in the root of the IaC repository (the same folder where this file is). 

- Choose which folder of resources you want to build. Note the path. All the directory and subscription information is stored inside the files.

- Run az login --allow-no-subscriptions. This will open a web browser and prompt for credentials.

- Run .\terraform.exe -chdir=directory_name init. This will download all the needed files from Terraform's registry. 

- Run .\terraform.exe -chdir=directory_name validate. This will make sure that we have all the required files and all the syntax is correct. It should output Success! The configuration is valid. If it doesn't, we have a problem.

- Run .\terraform.exe -chdir=directory_name plan. This will output a list of the changes that need to be made in order for the configuration in production to match the configuration specified in the Terraform file. Look over the plan and make sure it's not going to destroy any resources that aren't supposed to be destroyed.

- Run .\terraform.exe -chdir=directory_name apply. This will actually build the resources described in the Terraform file.
