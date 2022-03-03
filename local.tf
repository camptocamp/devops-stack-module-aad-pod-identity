locals {
  azure_identities = { for v in var.azure_identities :
    format("%s.%s", v.namespace, v.name) => {
      name         = v.name
      namespace    = v.namespace
      resource_id  = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].id
      client_id    = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].client_id
      principal_id = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].principal_id

    }
  }

  helm_values = [{
    aad-pod-identity = {
      azureIdentity = { for k, v in local.azure_identities :
        k => {
          name       = v.name
          namespace  = v.namespace
          resourceID = v.resource_id
          cliendID   = v.client_id
          type       = 0
          binding = {
            name     = v.name
            selector = v.name
          }
        }
      }
    }
  }]
}
