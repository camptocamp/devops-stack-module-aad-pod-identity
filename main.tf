resource "null_resource" "dependencies" {
  triggers = var.dependency_ids
}

data "azurerm_resource_group" "this" {
  name = var.node_resource_group_name
}

data "azurerm_subscription" "primary" {}

resource "azurerm_role_assignment" "managed_identity_operator" {
  for_each = toset(var.managed_identity_resource_groups)

  scope                = format("%s/resourcegroups/%s", data.azurerm_subscription.primary.id, each.key)
  role_definition_name = "Managed Identity Operator"
  principal_id         = var.cluster_managed_identity
}

resource "azurerm_role_assignment" "virtual_machine_contributor" {
  scope                = format("%s/resourcegroups/%s", data.azurerm_subscription.primary.id, data.azurerm_resource_group.this.name)
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = var.cluster_managed_identity
}

resource "azurerm_user_assigned_identity" "this" {
  for_each = {
    for k, v in var.azure_identities :
    format("%s.%s", v.namespace, v.name) => v
  }
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  name                = format("%s-%s-%s", each.value.namespace, each.value.name, var.cluster_name)
}

resource "argocd_project" "this" {
  metadata {
    name      = "aad-pod-identity"
    namespace = var.argocd_namespace
    annotations = {
      "devops-stack.io/argocd_namespace" = var.argocd_namespace
    }
  }

  spec {
    description  = "aad-pod-identity application project"
    source_repos = ["https://github.com/camptocamp/devops-stack-module-aad-pod-identity.git"]

    destination {
      server    = "*"
      namespace = "*"
    }

    orphaned_resources {
      warn = true
    }

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }
}

data "utils_deep_merge_yaml" "values" {
  input = [for i in concat(local.helm_values, var.helm_values) : yamlencode(i)]
}

resource "argocd_application" "this" {
  metadata {
    name      = "aad-pod-identity"
    namespace = var.argocd_namespace
  }

  wait = true

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-aad-pod-identity.git"
      path            = "charts/aad-pod-identity"
      target_revision = var.target_revision
      helm {
        values = data.utils_deep_merge_yaml.values.output
      }
    }

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    sync_policy {
      automated = {
        allow_empty = false
        prune       = true
        self_heal   = true
      }

      retry {
        backoff = {
          duration     = ""
          max_duration = ""
        }
        limit = "0"
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }

  depends_on = [
    resource.null_resource.dependencies,
  ]
}

resource "null_resource" "this" {
  depends_on = [
    resource.argocd_application.this,
  ]
}
