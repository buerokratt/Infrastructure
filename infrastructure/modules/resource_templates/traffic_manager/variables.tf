variable "public_ip_name" {
  description = "Name of the public ip"
  type        = string
}

variable "traffic_manager_name" {
  description = "Name of the azure traffic manager"
  type        = string
}

variable "traffic_manager_endpoint_name" {
  description = "Name of the azure traffic manager endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}