output "rg_out" {
  value = {
    id = data.azurerm_resource_group.rg.id
    name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
  }
}
