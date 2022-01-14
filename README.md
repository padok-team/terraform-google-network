# Google Network Terraform module

Terraform module which creates network, subnets, and few peerings resources on Google Cloud Platform.

## License

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## User Stories for this module

- AAUSER I can create network and its subnets
- AAUSER I can create network, its subnets and a VPC Peering with GCP network (used to connect a Cloud SQL instance)
- AAUSER I can create network, its subnets and a VPC connector used to access VPC resources from Cloud Functions or Cloud Run instances

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-google-network"

  name = "my-super-network"
  subnets = {
    "my-subnet1" = {
      cidr   = "10.20.0.0/16"
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
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets list. | <pre>map(object({<br>    cidr   = string<br>    region = string<br>  }))</pre> | n/a | yes |
| <a name="input_cloudrun"></a> [cloudrun](#input\_cloudrun) | If true, create a VPC network used by Cloud Run instances to access VPC resources. | `bool` | `false` | no |
| <a name="input_log_config_enable"></a> [log\_config\_enable](#input\_log\_config\_enable) | Indicates whether or not to export logs. | `bool` | `false` | no |
| <a name="input_log_config_filter"></a> [log\_config\_filter](#input\_log\_config\_filter) | Specifies the desired filtering of logs on this NAT. Possible values are ERRORS\_ONLY, TRANSLATIONS\_ONLY, and ALL. | `string` | `"ERRORS_ONLY."` | no |
| <a name="input_peerings"></a> [peerings](#input\_peerings) | Map of all the peerings to create with. | <pre>map(object({<br>    address = string<br>    prefix  = number<br>  }))</pre> | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | Google Cloud Platform project. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Google Cloud Platform region. | `string` | `null` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_network"></a> [compute\_network](#output\_compute\_network) | Name of created network and its subnets. |
<!-- END_TF_DOCS -->
