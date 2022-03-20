resource "google_service_account" "kubeip-sa" {
  account_id   = "kubeip-service-account"
  display_name = "kubeip"
  project      = var.project
}

resource "google_project_iam_custom_role" "kubeip-role" {
  project     = var.project
  role_id     = "kubeip"
  title       = "kubeip"
  description = "Required permission to run kubeip"
  permissions = [
    "compute.addresses.list",
    "compute.instances.addAccessConfig",
    "compute.instances.deleteAccessConfig",
    "compute.instances.get",
    "compute.instances.list",
    "compute.projects.get",
    "container.clusters.get",
    "container.clusters.list",
    "resourcemanager.projects.get",
    "compute.networks.useExternalIp",
    "compute.subnetworks.useExternalIp",
    "compute.addresses.use"
  ]
}

resource "google_project_iam_binding" "kubeip-iam-binding" {
  project = var.project
  role    = google_project_iam_custom_role.kubeip-role.id

  members = [
    "serviceAccount:${google_service_account.kubeip-sa.email}",
  ]
}


resource "google_service_account_key" "kubeip-sa-key" {
  service_account_id = google_service_account.kubeip-sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "kubeip-secret" {
  content = templatefile("${path.module}/tpl/kubeip-secret.tpl", {
    kubeip-serviceaccount = "${google_service_account_key.kubeip-sa-key.private_key}"
  })
  filename = "${path.module}/manifests/kubeip-secret.yaml"
}
