variable "task_definition_name" {
  type = string
  description = "Name for the task definition (attribute family at the AWS Task Definition Resource)"
}

variable "cpu" {
  type =number
  description = "Number of CPU units used by the Task Definition."
  default = null
}

variable "memory" {
  type = number
  description = "Amount of memory used by the task definition."
  default = null
}

variable "policy_arns" {
    type = list(string)
    description = "List of the arns of the policies that will be attached to the task execution role."
    default = []
}

variable "containers" {
  description = "List of containers at the task definition"
  type = list(object({
    name      : string
    image     : string
    cpu       : number
    memory    : number
    environment : list(object({
      name  : string
      value : string
    }))
  }))

  validation {
    condition     = length(var.containers) > 0
    error_message = "The containers list must not be empty."
  }
}

variable "region" {
    type = string   
    description = "Region of the log group of the container."
}