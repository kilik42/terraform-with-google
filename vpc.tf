
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
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.custom_vpc_network.id
}
