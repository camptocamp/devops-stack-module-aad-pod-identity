# devops-stack-module-aad-pod-identity

A [DevOps Stack](https://devops-stack.io) module to deploy and configure [aad-pod-identity](https://azure.github.io/aad-pod-identity/docs/) for AKS.

## Usage

```hcl

module "cluster" {
 source = "git::https://github.com/fsismondi/devops-stack.git//modules/aks/azure?ref=v1"

 cluster_name        = var.cluster_name
 kubernetes_version  = "1.21.9"
 base_domain         = azurerm_dns_zone.is_internal.name
 vnet_subnet_id      = azurerm_subnet.blue.id
 resource_group_name = azurerm_resource_group.default.name
 public_ssh_key      = tls_private_key.ssh_key.public_key_openssh
 oidc                = local.oidc
 agents_max_pods     = 250
 agents_size         = "Standard_D4s_v3"
}

module "aad-pod-identity" {
  source = "git::https://github.com/camptocamp/devops-stack-module-aad-pod-identity.git/"

  resource_group_name = azurerm_resource_group.default.name
  cluster_name     = var.cluster_name
  argocd_namespace = module.cluster.argocd_namespace
  base_domain      = module.cluster.base_domain
  
  azure_identities     = [    
    {
      namespace = "test"
      name      = "my-id"
    },
  ]
}

```

## Test

```bash
>> kubectl get AzureIdentity -A

NAMESPACE                NAME                               AGE
test                     my-id                              106d

```
