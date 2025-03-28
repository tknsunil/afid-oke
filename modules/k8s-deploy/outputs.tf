# modules/helm-afid-apps/output.tf

output "afid_release_status" {
  description = "The deployment status of the 'afid' Helm release."
  value       = helm_release.afid_app.status
}

output "afid_release_name" {
  description = "The name of the deployed 'afid' Helm release."
  value       = helm_release.afid_app.name
}

output "afid_release_namespace" {
  description = "The Kubernetes namespace where the 'afid' Helm release was deployed."
  value       = helm_release.afid_app.namespace
}

output "afid_release_chart_version" {
  description = "The version/reference of the 'afid' chart deployed (derived from Git ref)."
  value       = helm_release.afid_app.version # Note: For Git, this might show the ref used, not a semantic chart version
}

output "afid_detectors_release_status" {
  description = "The deployment status of the 'afid-detectors' Helm release."
  value       = helm_release.afid_detectors_app.status
}

output "afid_detectors_release_name" {
  description = "The name of the deployed 'afid-detectors' Helm release."
  value       = helm_release.afid_detectors_app.name
}

output "afid_detectors_release_namespace" {
  description = "The Kubernetes namespace where the 'afid-detectors' Helm release was deployed."
  value       = helm_release.afid_detectors_app.namespace
}

output "afid_detectors_release_chart_version" {
  description = "The version/reference of the 'afid-detectors' chart deployed (derived from Git ref)."
  value       = helm_release.afid_detectors_app.version # Note: For Git, this might show the ref used, not a semantic chart version
}
