variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "link_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_space" {
  type        = list(string)
  description = "Entre com a rede da subnet"
}

variable "vnet_name" {
  type        = string
  description = "Nome da Vnet"
}

variable "address_space" {
  type        = list(string)
  description = "Entre com a rede da Vnet"
}

#VAriaveis de Finops
variable "centro_custo" {
  type = string
}

variable "empresa" {
  type = string
}

variable "oper_resp" {
  type = string
}

variable "departamento" {
  type = string
}

variable "region" {
  type = string
}

variable "ambiente" {
  type = string
}

variable "bo" {
  type = string
}

variable "to" {
  type = string
}
