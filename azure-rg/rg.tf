provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.ambiente}-${var.rg_name}"
  location = var.location
  tags = {
    empresa          = var.empresa
    centro_de_custo  = var.centro_de_custo
    departamento     = var.departamento
    app              = var.app
    componente       = var.componente
    ambiente         = var.ambiente
    bo               = var.bo
    to               = var.to
    gerenciamento    = var.gerenciamento
  }
}
