variable "name_prefix" {
  description = "Prefix for the name of the provisioned resources."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones where the subnets will be created."
  type        = list(string)
}

variable "maximum_subnet_number" {
  description = "The number of the maximum subnets that the infrastructure will have (if you plan to add more subnets at the future, if this number is changed the VPC might be recreated)."
  type        = number
  default     = 256

  validation {
    condition     = var.maximum_subnet_number >= 2
    error_message = "Maximum number of subnets at the VPC it's too low. Minimum value is 2."
  }
}

variable "maximum_host_per_subnet" {
  description = "The maximum number of hosts that you expect to add in a single subnet."
  type        = number
  default     = 254

  validation {
    condition     = var.maximum_host_per_subnet >= 4
    error_message = "Maximum number of hosts per subnet too low. Minimum value is 4."
  }

}
