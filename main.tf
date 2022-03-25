resource "google_container_cluster" "main" {
  name                     = "main"
  location                 = var.location
  project                  = var.project
  remove_default_node_pool = true
  initial_node_count       = 1
  monitoring_service       = "none"
  logging_service          = "none"
}

resource "google_container_node_pool" "main" {
  name       = "main"
  location   = var.location
  project    = var.project
  cluster    = google_container_cluster.main.name
  node_count = var.node_count_per_node_pool

  management {
    auto_repair  = true
    auto_upgrade = true

  }


  node_config {
    preemptible  = true
    machine_type = "e2-standard-4"
    taint = [{
      key    = "main"
      value  = "true"
      effect = "NO_EXECUTE"
      }
    ]

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "setup" {
  name       = "setup"
  location   = var.location
  project    = var.project
  cluster    = google_container_cluster.main.name
  node_count = var.node_count_per_node_pool

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = "g1-small"
    disk_size_gb = 20

    labels = {
      ingress = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
