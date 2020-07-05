variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "dev-demo-bastion"
}

variable "administrator" {
  default = true
}

variable "allow_ip_address" {
  type = list(string)
  default = [
    "121.135.87.93/32",
    # "121.135.87.93/32", # echo "$(curl -sL icanhazip.com)/32"
  ]
}

variable "key_name" {
  default = "11st-ce-key-v1"
}

data "template_file" "setup" {
  template = file("template/setup.sh")

  vars = {
    HOSTNAME = var.name
  }
}