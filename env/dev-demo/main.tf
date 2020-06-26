# bastion

terraform {
  backend "remote" {
    organization = "11st" # org name from step 2.
    workspaces {
      name = "terraform-aws-bastion" # name for your app's state.
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "bastion" {
  source = "../../modules/bastion"

  region = "ap-northeast-2"
  city   = "SEOUL"
  stage  = "DEV"
  name   = "DEMO"
  suffix = "BASTION"

  vpc_id = "vpc-09f37431d9b6acffa"

  subnet_id = "subnet-05fae2d3eead1bd83"

  # ami_id = ""
  type = "t2.nano"

  key_name = "11st-ce-key-v1"

  allow_ip_address = [
    "175.126.171.161/32", # seoul-square echo "$(curl -sL icanhazip.com)/32"
  ]
}

output "name" {
  value = module.bastion.name
}

output "key_name" {
  value = module.bastion.key_name
}

output "public_ip" {
  value = module.bastion.public_ip
}
