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

#network
variable "network" {
  description = "The name of the network to which the instance will be connected."
  type        = string
  default     = "default" 
}

# subnetwork

variable "subnetwork" {
  description = "The name of the subnetwork to which the instance will be connected."
  type        = string
  default     = "default"
}

# 3. Create the Custom VPC Network using the variable
resource "google_compute_network" "custom_vpc_network" {
  name                    = var.network # Fits your network variable
  auto_create_subnetworks = false 
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

# 4. Create the Subnetwork using the variable
resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnetwork # Fits your subnetwork variable
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.custom_vpc_network.id
}