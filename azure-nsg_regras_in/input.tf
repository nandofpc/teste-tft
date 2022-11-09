variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "empresa" {
  type = string
}

variable "centro_de_custo" {
  type = string
}

variable "departamento" {
  type = string
}

variable "app" {
  type = string
}

variable "componente" {
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

variable "gerenciamento" {
  type = string
}

variable "regras_entrada" {
  type = map(any)
  default = {
    
  }
}
