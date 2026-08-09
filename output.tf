output "backend_service_id" {
  value = google_compute_backend_service.backend.id
}

output "url_map_id" {
  value = google_compute_url_map.url_map.id
}

output "health_check_id" {
  value = google_compute_health_check.http.id
}

output "backend_service_name" {
  value = google_compute_backend_service.backend.name
}

output "url_map_name" {
  value = google_compute_url_map.url_map.name
}

output "health_check_name" {
  value = google_compute_health_check.http.name
}