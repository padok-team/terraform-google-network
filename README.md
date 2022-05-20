# Google Network Terraform module

Terraform module which creates network, subnets, and few peerings resources on Google Cloud Platform.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_peering_cidr"></a> [gcp\_peering\_cidr](#input\_gcp\_peering\_cidr) | CIDR to reserve for GCP service in this VPC | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the network being created | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The list of subnets beeing created | <pre>object({<br>    name            = string<br>    region          = string<br>    primary_cidr    = string<br>    serverless_cidr = string<br>    secondary_ranges = map(object({<br>      name = string<br>      cidr = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL'). | `string` | `"GLOBAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_services_networking_connection"></a> [gcp\_services\_networking\_connection](#output\_gcp\_services\_networking\_connection) | The networking connection used by GCP for services like Cloud SQL |
| <a name="output_network"></a> [network](#output\_network) | The created network |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the VPC being created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | The URI of the VPC being created |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A map with keys of form subnet\_region/subnet\_name and values being the outputs of the google\_compute\_subnetwork resources used to create corresponding subnets. |
| <a name="output_subnets_ids"></a> [subnets\_ids](#output\_subnets\_ids) | The IDs of the subnets being created |
| <a name="output_subnets_names"></a> [subnets\_names](#output\_subnets\_names) | The names of the subnets being created |
<!-- END_TF_DOCS -->

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
