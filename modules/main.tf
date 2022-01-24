data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "this" {
  for_each = {
    for k, v in var.azureidentities :
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
      server    = "https://kubernetes.default.svc"
      namespace = var.namespace
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "kube-system"
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
  input = local.all_yaml
}

resource "argocd_application" "this" {
  metadata {
    name      = "aad-pod-identity"
    namespace = var.argocd_namespace
  }

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-aad-pod-identity.git"
      path            = "charts/aad-pod-identity"
      target_revision = "main"
      helm {
        values = data.utils_deep_merge_yaml.values.output
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = var.namespace
    }

    sync_policy {
      automated = {
        prune     = true
        self_heal = true
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }
}