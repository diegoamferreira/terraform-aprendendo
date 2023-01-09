variable "amis" {
  type = map
  
  default = {
    "us-east-1" = "ami-06878d265978313ca"
    "us-east-2" = "ami-0a606d8395a538502"
  }
}

variable "cdirs_acesso_remoto" {
  type = list
  
  default = [
    "191.17.228.118/32", "191.17.228.119/32"
  ]
}

variable "key_name" {
    default = "terraform-aws"
}