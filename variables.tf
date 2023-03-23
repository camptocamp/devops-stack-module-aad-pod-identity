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
  default     = "v1.1.1" # x-release-please-version
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

variable "app_autosync" {
  description = "Automated sync options for the Argo CD Application resource."
  type = object({
    allow_empty = optional(bool)
    prune       = optional(bool)
    self_heal   = optional(bool)
  })
  default = {
    allow_empty = false
    prune       = true
    self_heal   = true
  }
}

#######################
## Module variables
#######################

variable "azure_identities" {
  description = "Azure User Assigned Identities to create."
  type = list(object({
    namespace = string
    name      = string
  }))
  default = []
}

variable "node_resource_group_name" {
  description = "The Resource Group of the node pools. It will be used for new Managed Identities."
  type        = string
}

variable "managed_identity_resource_groups" {
  description = "The Resource Groups where this component operates managed identities."
  type        = list(string)
}

variable "cluster_managed_identity" {
  description = "ID of the cluster managed identity"
  type        = string
}
