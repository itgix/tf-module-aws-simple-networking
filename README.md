The Terraform module is used by the ITGix AWS Landing Zone - https://itgix.com/itgix-landing-zone/

# AWS Simple Networking Terraform Module

This module creates a VPC networking stack similar to the full networking module but with a simplified interface. Supports public, private, database, elasticache, redshift, and intra subnets, NAT gateways, VPN gateways, and VPC flow logs.

Part of the [ITGix AWS Landing Zone](https://itgix.com/itgix-landing-zone/).

## Resources Created

- VPC with optional IPv6 and DHCP options
- Public, private, database, elasticache, redshift, and intra subnets
- Internet Gateway and NAT Gateways
- Route tables with configurable routes
- Network ACLs
- VPC Flow Logs (CloudWatch and/or S3)
- *(Optional)* VPN Gateway

## Key Inputs

> This module has **170+ variables**. The most commonly used are listed below. See `variables.tf` for the complete list.

### VPC

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `create_vpc` | Controls if VPC should be created | `bool` | `true` | no |
| `name` | Name used on all resources as identifier | `string` | `""` | no |
| `cidr` | IPv4 CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| `azs` | List of availability zones | `list(string)` | `[]` | no |
| `enable_dns_hostnames` | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| `enable_dns_support` | Enable DNS support in the VPC | `bool` | `true` | no |
| `tags` | Tags for all resources | `map(string)` | `{}` | no |

### Subnets

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `public_subnets` | List of public subnet CIDRs | `list(string)` | `[]` | no |
| `private_subnets` | List of private subnet CIDRs | `list(string)` | `[]` | no |
| `database_subnets` | List of database subnet CIDRs | `list(string)` | `[]` | no |
| `elasticache_subnets` | List of elasticache subnet CIDRs | `list(string)` | `[]` | no |
| `redshift_subnets` | List of redshift subnet CIDRs | `list(string)` | `[]` | no |
| `intra_subnets` | List of intra subnet CIDRs (no internet access) | `list(string)` | `[]` | no |

### NAT Gateway

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `enable_nat_gateway` | Provision NAT Gateways | `bool` | `false` | no |
| `single_nat_gateway` | Use a single NAT Gateway | `bool` | `false` | no |
| `one_nat_gateway_per_az` | One NAT Gateway per AZ | `bool` | `false` | no |

### VPC Flow Logs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `enable_flow_log` | Enable VPC Flow Logs | `bool` | `false` | no |
| `flow_log_destination_type` | Destination type (cloud-watch-logs or s3) | `string` | `"cloud-watch-logs"` | no |

## Key Outputs

> This module has **109 outputs**. The most commonly used are listed below. See `outputs.tf` for the complete list.

| Name | Description |
|------|-------------|
| `vpc_id` | The ID of the VPC |
| `vpc_arn` | The ARN of the VPC |
| `vpc_cidr_block` | The CIDR block of the VPC |
| `public_subnets` | List of public subnet IDs |
| `private_subnets` | List of private subnet IDs |
| `database_subnets` | List of database subnet IDs |
| `public_route_table_ids` | List of public route table IDs |
| `private_route_table_ids` | List of private route table IDs |
| `nat_public_ips` | List of NAT Gateway public IPs |

## Usage Example

```hcl
module "simple_networking" {
  source = "path/to/tf-module-aws-simple-networking"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_flow_log           = true
  flow_log_destination_type = "cloud-watch-logs"

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```
