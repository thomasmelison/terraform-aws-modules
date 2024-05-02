variable "name_prefix" {
  description = "Prefix for the name of the provisioned resources."
  type = string
}

variable "availability_zones"{
	description = "List of availability zones of the network."
  type = list(string)
}

variable "maximum_subnet_number" {
  type = number
  default = 256
}

variable "maximum_host_per_subnet" {
  type = number
  default = 254
}

