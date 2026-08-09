resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-firewall"
  network = google_compute_network.custom_vpc_network.id
  description = "Allow HTTP and ICMP traffic from the source tag 'web' to the instances in the network."

  allow {
    protocol = "icmp"# this is for ping requests
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"] # this allows traffic on ports 80, 8080, and the range 1000-2000
  }

  source_ranges = ["0.0.0.0/0"] # this allows traffic from any IP address. You can restrict this to specific IP ranges if needed.

  source_tags = ["web"]
}
# the fire wall allows traffic from the source tag "web" to the instances in the network. The firewall allows ICMP traffic and TCP traffic on ports 80, 8080, and 1000-2000. The firewall is applied to the custom VPC network created in the vpc.tf file.


# resource "google_compute_network" "default" {
#   name = "test-network"
# }