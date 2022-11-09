# Documentação do Modulo de Resource Group (Criação)


## 1. Nomenclatura

O nome é definido na variavel var.name

## 2. Configurar os parâmetros necessários

* Seguir documentação do módulo

## 3. Inicializar o Terraform

```
terraform init
```

##  4. Avaliar o plano de execução do Terraform

```
terraform plan 
```

## 5. Executar o Terraform

```bash
terraform apply 
```

## 6. Destruir o recurso/stack criado

```
terraform destroy 
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_rgname"></a> [rgname](#input\_rgname) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rg"></a> [rg](#output\_rg) | n/a |
<!-- END_TF_DOCS -->