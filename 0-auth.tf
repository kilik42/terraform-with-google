terraform {
  required_providers {
    google = {
      version = "~> 7.30.0"
    }
  }
}


provider "google" {
  project = var.project_id
  region  = var.region
}