output "nsg_out" {
  value = {
    name = azurerm_network_security_group.nsg.name
    id   = azurerm_network_security_group.nsg.id
  }
} 
