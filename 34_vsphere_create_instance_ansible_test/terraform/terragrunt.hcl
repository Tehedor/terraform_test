terraform {
  source = "./"

  extra_arguments "env_vars" {
    commands = ["plan", "apply", "destroy"]
    arguments = ["-var-file=enviroments/terraform.tfvars"]
  }
}