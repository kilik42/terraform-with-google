# what this does is create a google compute instance template with apache2 installed and running on startup. The template can be used to create instances in a managed instance group or individually.
# Step 1: Define the Instance Template The template acts as a blueprint for the virtual machines.

resource "google_compute_instance_template" "template" {
  name         = "${var.name}-template"
  machine_type = var.machine_type
  region      = var.region

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
      //allocates an ip address to the instance for external access
    }
    
  }

  lifecycle {
    create_before_destroy = true
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

# Create a health check for the instances in the managed instance group
#Step 2: Implement Auto-Healing
#
resource "google_compute_health_check" "app_health_check" {
  name                = "app-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    request_path = "/healthz"
    port         = 8080
  }
}


# Step 3: Create the Regional Managed Instance Group A regional MIG automatically spreads your instances across multiple zones inside a single region to establish zone-level fault tolerance

resource "google_compute_region_instance_group_manager" "app_mig" {
  name               = "app-mig"
  base_instance_name = "app-worker"
  region             = var.region
  # instance_template  = google_compute_instance_template.template.id
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.template.id
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.app_health_check.id
    initial_delay_sec = 300 # Wait 5 mins for instance initialization before health checks start
  }

  # Configures how updates are rolled out across the fleet
  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 3
    max_unavailable_fixed = 0
  }
}


# Step 4: Add Auto-Scaling Rules
#An autoscaler pairs directly with your managed group to dynamically adjust the server count matching production demands

resource "google_compute_region_autoscaler" "app_autoscaler" {
  name   = "app-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.app_mig.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.6 # Target 60% average CPU usage
    }
  }
}
