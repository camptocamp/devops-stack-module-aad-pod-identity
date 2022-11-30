#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "argocd_namespace" {
  type = string
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "main"
}

variable "namespace" {
  type    = string
  default = "aad-pod-identity"
}

variable "helm_values" {
  description = "Helm values, passed as a list of HCL structures."
  type        = any
  default     = []
}

variable "dependency_ids" {
  type = map(string)

  default = {}
}

#######################
## Module variables
#######################

variable "azure_identities" {
  description = "Azure User Assigned Identities to create"
  type = list(object({
    namespace = string
    name      = string
  }))
  default = []
}

variable "node_resource_group_name" {
  description = "The Resource Group of the node pools."
  type        = string
}

variable "cluster_managed_identity" {
  description = "ID of the cluster managed identity"
  type = string
}
