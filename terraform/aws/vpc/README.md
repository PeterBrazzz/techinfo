## ------ VPC subnet module  ------ 
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Override default az list. By default the module uses all availables azs in the current region. | `list(string)` | `[]` | no |
| <a name="input_cidr_suffix"></a> [cidr\_suffix](#input\_cidr\_suffix) | Suffix that is used in subnet CIDR masks. | `number` | n/a | yes |
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | A key - value list of additional tags, that is attached to elastic ip. | `map(string)` | `{}` | no |
| <a name="input_igw_tags"></a> [igw\_tags](#input\_igw\_tags) | A key - value list of additional tags, that is attached to internet gateway. | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for all resources. | `string` | n/a | yes |
| <a name="input_nat_subnets"></a> [nat\_subnets](#input\_nat\_subnets) | A list of public subnet ids that are used by NAT. | `list(string)` | `[]` | no |
| <a name="input_nat_tags"></a> [nat\_tags](#input\_nat\_tags) | A key - value list of additional tags, that is attached to nat gateway. | `map(string)` | `{}` | no |
| <a name="input_rt_tags"></a> [rt\_tags](#input\_rt\_tags) | A key - value list of additional tags, that is attached to route tables. | `map(string)` | `{}` | no |
| <a name="input_subnet_tags"></a> [subnet\_tags](#input\_subnet\_tags) | A key - value list of additional tags, that is attached to subnets. | `map(string)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Override default subnet count. By default subnet count = number of azs in the current region. | `number` | `0` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | VPC sunbets ids. |
| <a name="output_rt_id"></a> [rt\_id](#output\_rt\_id) | VPC route tables ids. |

## ------ VPC endpoints module ------ 
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint_tags"></a> [endpoint\_tags](#input\_endpoint\_tags) | A key - value list of additional tags, that is attached to vpc endpoint. | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for all resources. | `string` | n/a | yes |
| <a name="input_private_dns_enabled"></a> [private\_dns\_enabled](#input\_private\_dns\_enabled) | Whether or not to associate a private hosted zone with the specified VPC. | `bool` | `false` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | AWS service name that is used. | `string` | n/a | yes |
| <a name="input_sg_tags"></a> [sg\_tags](#input\_sg\_tags) | A key - value list of additional tags, that is attached to security group. | `map(string)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet ids connected to the endpoint. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id. | `string` | n/a | yes |

## Outputs

No outputs.

## ------ VPC flow logs module ------ 