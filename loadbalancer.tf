module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 12.0" # Use the latest version
  name              = var.load_balancer_name
  project           = var.project_id
  target_tags       = ["allow-lb-traffic"]
  
  backends = {
    default = {
      description = "Default backend security group"
      protocol    = "HTTP"
      port        = 80
      port_name   = "http"
      timeout_sec = 10
      enable_cdn  = false

      # Link your Managed Instance Groups (MIG) or Network Endpoint Groups (NEG)
      groups = [
        {
          group = "projects/${var.project_id}/zones/${var.zone}/instanceGroups/my-mig"
        }
      ]

      health_check = {
        request_path = "/"
        port         = 80
      }
    }
  }
}
