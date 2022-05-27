# Basic

## Specifications

- 1 Subnet
- 2 Secondary range for pods dans services (must not overlap the subnet CIDR)
- Peering with Google

## Example

[Link](https://github.com/padok-team/terraform-google-network/blob/main/examples/gke/main.tf)

```terraform
{%
   include "../../examples/gke/main.tf"
%}
```