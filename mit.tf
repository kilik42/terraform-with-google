# what this does is create a google compute instance template with apache2 installed and running on startup. The template can be used to create instances in a managed instance group or individually.
resource "google_compute_instance_template" "template" {
  name         = "${var.name}-template"
  machine_type = "e2-medium"

  disk {
    source_image = var.machine_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
  EOT

  tags = ["http-server"]
}