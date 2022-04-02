resource "google_artifact_registry_repository" "my-repo" {
  provider = google-beta

  location = "us-central1"
  repository_id = "hackathon-6aso"
  description = "Imagens Docker"
  format = "DOCKER"
}

resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  dump_file_path = "Playlist.sql"
  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}

variable "DATABASE_USER" {
  type = string
  default = ""
}

variable "DATABASE_PASSWORD" {
  type = string
  default = ""
}

variable "TFC_CONFIGURATION_VERSION_GIT_BRANCH" {
  type = string
  default = ""
}

resource "google_sql_database" “database” {
	name = "main-database"
	instance = "${google_sql_database_instance.main.name}"
	charset = "utf8"
	collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
	name = var.DATABASE_USER
	instance = "${google_sql_database_instance.main.name}"
	host = "%"
	password = var.DATABASE_PASSWORD
}