# Terraform-Project1
# A good Terraform code is a repeatable and reusable code.
---------------------------------------------------------------------------

# Deliveries:

- The deployed architecture is  identical to the stated need.

- No password  appears hard in  code (use of variables).

- The design of  architecture is  "stacked", readable and easy to deploy (use of modules).

- More generally, this is a  good practices  for the use of Terraform.

- Use of the HCL language.
# Installation 


sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
 install the HashiCorp GPG key :

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

key's fingerprint.
echo gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint


Let's add the official HashiCorp repository to our system
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

download the package information from HashiCorp.
sudo apt update

sudo apt-get install terraform
terraform --version



terraform --version
Terraform v1.12.1
on linux_amd64
