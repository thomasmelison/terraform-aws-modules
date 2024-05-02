variable "name_prefix" {
  description = "Prefix for the name of the provisioned resources."
  type = string
}

variable "availability_zones"{
	description = "List of availability zones where the subnets will be created."
  type = list(string)
}

variable "maximum_subnet_number" {
  description = "The number of the maximum subnets that the infrastructure will have (if you plan to add more subnets at the future, if this number is changed the VPC might be recreated)."
  type = number
  default = 256
}

variable "maximum_host_per_subnet" {
  description = "The maximum number of hosts that you expect to add in a single subnet."
  type = number
  default = 254
}

variable "validate_network_settings" {
  description = "Variable only used for validation of the other variables at this module."
  type        = bool
  default     = true
  

  validation {
    condition = (
      local.subnet_bits >= 1 &&
      local.host_bits >= 2 &&
      (local.subnet_bits + local.host_bits) <= 24
    )
    error_message = "Network settings validation failed."
  }
}
