terraform {
  backend "remote" {
    organization = "gregtyler"

    workspaces {
      name = "wp-multisite"
    }
  }
}