
variable "profile" {
  type    = string
  default = "default"
}


variable "region-monitoring" {
  type    = string
  default = "us-east-1"
}

variable "external-ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance-type" {
  type    = string
  default = "t3.medium"
}

