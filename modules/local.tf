locals {
  profiles_yaml = [for i in var.profiles : templatefile("${path.module}/profiles/${i}.yaml", {
    azureidentities = local.azureidentities,
  })]
  all_yaml = concat(local.profiles_yaml, var.extra_yaml)

  azureidentities = { for v in var.azureidentities :
    format("%s.%s", v.namespace, v.name) => {
      name         = v.name
      namespace    = v.namespace
      resource_id  = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].id
      client_id    = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].client_id
      principal_id = azurerm_user_assigned_identity.this[format("%s.%s", v.namespace, v.name)].principal_id
    }
  }
}
