variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "ecs-network"
}

variable "owner" {
  type    = string
  default = "gaston"
}

variable "env" {
  type    = string
  default = "lab"
}

variable "tags" {
  description = "Tags adicionales"
  type        = map(string)
  default     = {}
}

# Prefijo único para nombres
variable "name_prefix" {
  type    = string
  default = "ecs"
}

# CIDRs
variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "pub1_cidr" {
  type    = string
  default = "192.168.10.0/24"
}

variable "pub2_cidr" {
  type    = string
  default = "192.168.20.0/24"
}

variable "priv1_cidr" {
  type    = string
  default = "192.168.30.0/24"
}

variable "priv2_cidr" {
  type    = string
  default = "192.168.40.0/24"
}
