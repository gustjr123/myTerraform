# 요약

### NAT Gateway의 금액이 매우 많이 들기 때문에 EC2 인스턴스를 NAT 서버로 활용한다.

- - -

# Example Usage

### main.tf
``` terraform
module "nat_instance" {
  source = "./modules/nat"

  name           = "nat-instance"
  vpc_id         = "vpc-123456abcdefg"
  vpc_cidr_ipv4  = "10.0.0.0/16"
  subnet_id      = "subnet-123456abcdefg"
  pvt_subnet_ids = ["subnet-123456abcdefg", "subnet-789456abcdefg"]
  ssh_key        = "demo-key"
}
```

### outputs.tf
``` terraform 
output "name" {
  description = "Name of the instance"
  value       = module.nat_instance.name
}

output "id" {
  description = "ID of the instance"
  value       = module.nat_instance.id
}

output "NIC_name" {
  description = "Name of the NAT instance's network interface"
  value       = module.nat_instance.network_interface_name
}

output "NIC_id" {
  description = "ID of the NAT instance's network interface"
  value       = module.nat_instance.network_interface_id
}
```

- - -

# Argument Reference
|Argument|Description|Option|
|:--|:--|:--:|
|name           | nat instance 이름 | Optional
|vpc_id         | VPC id | Required
|vpc_cidr_ipv4  | VPC CIDR | Required
|subnet_id      | nat instance가 위치하는 public subnet | Required
|pvt_subnet_ids | nat instance로 외부와 연결하려는 private subnet | Required
|ssh_key        | nat instance의 ssh key | Required

- - -

# Attribute Reference
|Argument|Description|Value|
|:--|:--|:--|
|name        | nat instance 이름 | module.<module 이름>.name
|id          | nat instance ID | module.<module 이름>.id
|NIC_name    | NIC tag 이름 | module.<module 이름>.network_interface_name
|NIC_id      | NIC ID | module.<module 이름>.network_interface_id

- - -

# Import

repository의 modules 디렉토리를 통째로 원하는 VM에 넣는다. 

본인의 main.tf파일에서 위 예시를 확인하여 module을 사용한다.

#### Example
```
Terraform Dictionary Tree
├ main.tf (your code)
├ outputs.tf (your code)
├ variables.tf (your code)
└ modules 
  └ nat-instance
  └ others
  └ ...
```