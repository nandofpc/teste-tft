provider "azurerm" {
  features {
  }

}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
  tags = {
    centro_custo = var.centro_custo
    empresa      = var.empresa
    oper_resp    = var.oper_resp
    departamento = var.departamento
    region       = var.region
    ambiente     = var.ambiente
    bo           = var.bo
    to           = var.to
  }
}

resource "azurerm_virtual_network" "vnet" {
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  name                = var.vnet_name
  address_space       = var.address_space
  tags                = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.subnet_space
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP_Rules"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH_Rules"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = azurerm_resource_group.rg.tags

}


resource "azurerm_subnet_network_security_group_association" "associate_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_private_dns_zone" "dns" {
  name                = var.dns_name
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-dns" {
  name                  = var.link_name
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}

#Adicionando uma VM Linux

# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  tags                = azurerm_resource_group.rg.tags
}

# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip2" {
  name                = "myPublicIP2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  tags                = azurerm_resource_group.rg.tags
}

#Nic para a VM

resource "azurerm_network_interface" "nic" {
  name                = "nic001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  ip_configuration {
    name                          = "internal-pip"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id

  }

}

resource "azurerm_network_interface" "nic2" {
  name                = "nic002"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  ip_configuration {
    name                          = "internal-pip2"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip2.id

  }

}

resource "azurerm_virtual_machine" "main" {
  name                = "VmLinux001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vm_size             = "Standard_DS1_v2"
  tags                = azurerm_resource_group.rg.tags
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]


  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "VMLinux001"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data = base64encode(local.custom_data)
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

## Windows Machine
resource "azurerm_windows_virtual_machine" "example" {
  name                = "VMWin001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_DS1_v2"
  admin_username      = "testadmin"
  admin_password      = "P@$$w0rd1234!"
  tags                = azurerm_resource_group.rg.tags
  network_interface_ids = [
    azurerm_network_interface.nic2.id
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
    #custom_data     =  file("dns.ps1")

  }
}

resource "azurerm_virtual_machine_extension" "linux-script" {
  name = azurerm_virtual_machine.main.name
  virtual_machine_id   = azurerm_virtual_machine.main.id 
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings             = <<SETTINGS
        {
            "commandToExecute": "sudo apt-get update && sudo timedatectl set-timezone America/Sao_Paulo && apt-get install python -y"
        }
SETTINGS
  depends_on = [
    azurerm_virtual_machine.main
  ]
}

