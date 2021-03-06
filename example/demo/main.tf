terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-11st-demo-state"
    key            = "bastion.tfstate"
    # dynamodb_table = "for locking"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "bastion" {
  source = "../../"

  name = var.name

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]

  administrator = var.administrator

  allow_ip_address = var.allow_ip_address

  user_data = data.template_file.setup.rendered

  key_name = var.key_name
}