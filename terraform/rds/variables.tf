variable "cluster_name" {
  type = string
  default = "<CHANGE>"
}

variable "instance_class" {
  type = string
  default = "<CHANGE>"
}

variable "username" {
  type = string
  default = "<CHANGE>"
}

variable "password" {
  type = string
  default = "<CHANGE>"
}

variable "my_vpc_sg_ids" {
  type = list
  default = ["<CHANGE>"]
}

variable "my_subnet_ids" {
  type = list
  default = ["<CHANGE>"]
}

variable "my_subnet_group_name" {
  type = string
  default = ""<CHANGE>""
}

variable "my_cluster_parameter_group_name" {
  type = string
  default = ""<CHANGE>""
}

variable "my_db_parameter_group_name" {
  type = string
  default = ""<CHANGE>""
}
