terraform {
  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = ">= 6"
    }
    utils = {
      source = "cloudposse/utils"
    }
  }
}
