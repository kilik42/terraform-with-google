variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "training-416401"
}

variable "region" {
  description = "The region in which to provision resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which to provision resources."
  type        = string
  default     = "us-central1-a"
}

variable "name" {
  description = "The name of the resources to be created."
  type        = string
  default     = "training"
}

#MACHINE IMAGE
variable "machine_image" {
  description = "The machine image to use for the instance."
  type        = string
  default     = "projects/debian-cloud/global/images/family/debian-11"
}

# machine type
variable "machine_type" {
  description = "The machine type to use for the instance."
  type        = string
  default     = "e2-medium"
}
#network
variable "network" {
  description = "The name of the network to which the instance will be connected."
  type        = string
  default     = "default" 
  # do we need to create a custom network? if yes, then we need to change the default value to the name of the custom network.
  # example: "custom-vpc-network"
}

# subnetwork

variable "subnetwork" {
  description = "The name of the subnetwork to which the instance will be connected."
  type        = string
  default     = "default"
  #example : "custom-subnet"
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnetwork."
  type        = string
  default     = "10.0.1.0/24"
}

# environment variable
variable "environment" {
  description = "The environment in which the resources will be provisioned."
  type        = string
  default     = "dev"
}