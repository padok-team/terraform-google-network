# Terraform GCP Network module

Terraform module which creates a network, subnets and peerings on Google Cloud Platform.

## User Stories for this module

- AAUSER I can create a network with subnets
- AAUSER I can create a network with subnets and a VPC Peering with GCP network (used to connect a Cloud SQL or Memorystore instance)
- AAUSER I can create a network with subnets and a VPC connector used to access VPC resources from Cloud Functions or Cloud Run instances

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-google-network"

  name = "my-super-network"
  subnets = {
    "my-subnet1" = {
      cidr = "10.20.0.0/16"
      region = "europe-west3"
    }
  }
}
```

## Examples

- [Example of minimal network configuration use case (one VPC and one subnet)](examples/minimal_network_configuration/main.tf)
- [Example of network with multi regional subnets use case](examples/multi_regional_subnets/main.tf)
- [Example of network with cloudrun activated](examples/cloudrun/main.tf)
- [Example of network with a cloudsql peering](examples/cloudsql/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the network | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets list | <pre>map(object({<br>    cidr   = string<br>    region = string<br>  }))</pre> | n/a | yes |
| <a name="input_cloudrun"></a> [cloudrun](#input\_cloudrun) | If true, create a VPC network used by Cloud Run instances to access VPC resources. | `bool` | `false` | no |
| <a name="input_delete_default_network"></a> [delete\_default\_network](#input\_delete\_default\_network) | If true, deletes the default VPC | `bool` | `false` | no |
| <a name="input_log_config_enable"></a> [log\_config\_enable](#input\_log\_config\_enable) | Indicates whether or not to export logs. | `bool` | `false` | no |
| <a name="input_log_config_filter"></a> [log\_config\_filter](#input\_log\_config\_filter) | Specifies the desired filtering of logs on the NAT. Possible values are ERRORS\_ONLY, TRANSLATIONS\_ONLY, and ALL | `string` | `"ERRORS_ONLY"` | no |
| <a name="input_peerings"></a> [peerings](#input\_peerings) | Map of all the peering to create with the module | <pre>map(object({<br>    address = string<br>    prefix = number<br>  }))</pre> | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | Google Cloud Platform project | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Google Cloud Platform region | `string` | `null` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across all regions. | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | Name, ID and subnets of created network. |
<!-- END_TF_DOCS -->
