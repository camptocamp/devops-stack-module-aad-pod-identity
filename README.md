# devops-stack-module-aad-pod-identity

A [DevOps Stack](https://devops-stack.io) module to deploy and configure [aad-pod-identity](https://azure.github.io/aad-pod-identity/docs/) for AKS.

## Usage

```hcl
module "aad-pod-identity" {
  source = "git::https://github.com/camptocamp/devops-stack-module-aad-pod-identity.git/"

  resource_group_name = azurerm_resource_group.default.name
  cluster_name     = var.cluster_name
  argocd_namespace = module.cluster.argocd_namespace
  base_domain      = module.cluster.base_domain
}

```
