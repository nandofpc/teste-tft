output "subnet_out" {
  value = {
    id = azurerm_private_dns_zone.dns.id
  }
}

output "ipad" {
  value = {
    ip_address = azurerm_public_ip.my_terraform_public_ip2.ip_address
  }

}