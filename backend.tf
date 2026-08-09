# google compute health check resource
resource "google_compute_health_check" "http" {
  name               = "${var.name}-http-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
    request_path = "/"
  }

}


# google computer backend service resource
resource "google_compute_backend_service" "backend" {
  name                  = "${var.name}-backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.http.id]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group            = google_compute_instance_group.backend.self_link
    balancing_mode   = "UTILIZATION"
    capacity_scaler  = 1.0
    max_utilization  = 0.8
  }
}


# url map
resource "google_compute_url_map" "url_map" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.backend.id
}


