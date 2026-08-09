resource "google_computer_router" "router" {
  name    = "${var.name}-router"
  network = google_compute_network.custom_vpc_network.self_link
  region  = var.region

  # bgp configuration is required for the router to establish a BGP session with the Cloud Router.
  #bgp is a protocol used to exchange routing information between different networks. In this case, it is used to establish a BGP session between the Cloud Router and the on-premises network.
  bgp {
    asn = 65001 # this is the ASN (Autonomous System Number) for the Cloud Router. It is used to identify the Cloud Router in the BGP session.
  }

  depends_on = [google_compute_network.custom_vpc_network]
}

# a router file is used to create a Cloud Router in Google Cloud Platform (GCP). A Cloud Router is a fully distributed and managed Google Cloud service that enables dynamic routing between your Virtual Private Cloud (VPC) network and on-premises networks or other VPC networks. It allows you to establish BGP sessions with your on-premises routers or other VPC networks, enabling the exchange of routing information and facilitating communication between different networks.