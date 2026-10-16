variable "project_name" {
  description = "base name for project"
  type        = string
  default     = "kloud"
}

variable "location" {
  description = "where resources are deployed"
  type        = string
  default     = "South Africa North"
}

variable "tags" {
  description = "common tags applied to resources"
  type        = map(string)
  default = {
    "environment" = "Dev"
    "owner"       = "Ysiri"
  }
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "kv_sku" {
  type    = string
  default = "standard"
}

variable "aks_nodepool_count" {
  type    = number
  default = 1
}

variable "aks_vm_size" {
  type    = string
  default = "Standard_D2_v2"
}

variable "aks_nodepool_name" {
  type    = string
  default = "nodepool1"
}
