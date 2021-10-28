# GOOGLE Terraform module

Terraform module which creates network, subnets, and few peerings resources on Google Cloud Platform.

## User Stories for this module

- AAUSER I can create network and its subnets
- AAUSER I can create network, its subnets and a VPC Peering with GCP network (used to connect a Cloud SQL instance)
- AAUSER I can create network, its suvnets and a VPC connector used to access VPC resources from Cloud Functions or Cloud Run instances

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-google-network"

  network_name = "my-super-network"
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
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets list | <pre>map(object({<br>    cidr = string<br>  }))</pre> | n/a | yes |
| <a name="input_cloudrun"></a> [cloudrun](#input\_cloudrun) | If true, create a VPC network used by Cloud Run instances to access VPC resources. | `bool` | `false` | no |
| <a name="input_cloudsql"></a> [cloudsql](#input\_cloudsql) | If true, create VPC peering for CloudSQL. | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Google Cloud Platform region | `string` | `null` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | n/a |
<!-- END_TF_DOCS -->
