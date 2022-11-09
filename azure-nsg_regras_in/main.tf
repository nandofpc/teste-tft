provider "azurerm" {
  features {
  }
}

resource "random_string" "number" {
  length  = 3
  upper   = false
  lower   = false
  numeric  = true
  special = false
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.ambiente}-${var.nsg_name}-${random_string.number.result}" 
  resource_group_name = var.rg_name
  location            = var.location
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

resource "azurerm_network_security_rule" "regras_entrada" {
  for_each                    = var.regras_entrada
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  name                        = "porta_entrada_${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  source_port_range           = "*"
  protocol                    = "Tcp"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}
