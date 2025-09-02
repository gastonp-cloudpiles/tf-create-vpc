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

# Nombres
variable "vpc_name" {
  type    = string
  default = "ecs-vpc"
}

variable "igw_name" {
  type    = string
  default = "ecs-igw"
}

variable "natgw_name" {
  type    = string
  default = "ecs-natgw"
}

variable "rt_public_name" {
  type    = string
  default = "ecs-rt-pub"
}

variable "rt_priv1_name" {
  type    = string
  default = "ecs-rt-priv1"
}

variable "rt_priv2_name" {
  type    = string
  default = "ecs-rt-priv2"
}

variable "pub1_name" {
  type    = string
  default = "ecs-pub1"
}

variable "pub2_name" {
  type    = string
  default = "ecs-pub2"
}

variable "priv1_name" {
  type    = string
  default = "ecs-priv1"
}

variable "priv2_name" {
  type    = string
  default = "ecs-priv2"
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
