variable "cluster_name" {
  type = string
  default = "eks-nonpd-us"
}

variable "key" {
  type = string
  default = "mc1keylinuxvirginia"
}

variable "node" {
  type = string
  default = "ng-default"
}

variable "k8s_version" {
  type = string
  default = "1.20"
}

variable "vpc_cidr" {
  type = string
  default = "10.238.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "VPC-EKS-NONPROD-US"
}

variable "env" {
  type = string
  default = "eks-nonProd"
}

variable "pub_subnets" {
  type = list
  default = ["10.238.0.0/20", "10.238.16.0/20"]
}

variable "pri_subnets" {
  type = list
  default = ["10.238.32.0/20", "10.238.48.0/20"]
}

variable "az" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}
