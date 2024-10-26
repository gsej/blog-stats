variable "location" {
  description = "The region where resources will be created"
  type        = string
  default     = "UK South"
}

variable "service-name" {
    type = string
    default = "goatcounter"
}