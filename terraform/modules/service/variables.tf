variable "subnets" {
  type = list(string)
}

variable "cluster_arn" {}

variable "namespace" {}
variable "namespace_id" {}

variable "vpc_id" {}

variable "container_image" {}
variable "container_port" {
  type = number
}

variable "nginx_container_image" {}
variable "nginx_container_port" {
  type = number
}

variable "security_group_ids" {
  type = list(string)
}

variable "env_vars" {
  type = map(string)
}

variable "secret_env_vars" {
  type = map(string)
}

variable "lb_arn" {}
variable "listener_port" {
  type = number
}

variable "cpu" {
  default = 1024
  type    = number
}

variable "memory" {
  default = 2048
  type    = number
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "launch_type" {
  default = "FARGATE"
}

variable "desired_task_count" {
  default = 3
}
