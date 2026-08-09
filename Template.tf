# web server compute instance

resource "google_compute_instance" "web_server" {
  name         = "${var.name}-web-server"
  machine_type =  var.machine_type
#   region      = var.region
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.machine_image
      labels = {
        environment = var.environment
      }
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      // Ephemeral public IP
      //allocates an ip address to the instance for external access
    }
  }

  metadata_startup_script = file("startup-script.sh")
}