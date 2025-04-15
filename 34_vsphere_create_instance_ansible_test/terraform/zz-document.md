export VAULT_ADDR='http://kmaster01.lab.local:8200'
export VAULT_TOKEN='pruebas123'




terraform init
terraform validate -var-file=enviroments/terraform.tfvars
terraform plan -var-file=enviroments/terraform.tfvars
terraform apply -var-file=enviroments/terraform.tfvars