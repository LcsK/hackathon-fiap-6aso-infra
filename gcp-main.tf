resource "google_artifact_registry_repository" "my-repo" {
  provider = google-beta

  location = "us-central1"
  repository_id = "hackathon-6aso"
  description = "Imagens Docker"
  format = "DOCKER"
}
