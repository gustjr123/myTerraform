# 개요

Transit Gateway와 customer gateway 및 connection 생성 예제

- - -

# Example Usage

### main.tf
``` terraform
module "tgw-cgw-conn" {
  source = "./modules/transit-gateway"

  # cgw attribute
  cgwIP  = "54.180.121.220"
  cgwASN = 65000

  # attach attribute
  attachVpcId        = "vpc-010c17f3908d854a2"
  attachVpcSubnetIds = ["subnet-0ec2abc8782992df4", "subnet-044e00cc2601039ba"]

  # rtb attribute
  rtbId           = "rtb-0ae106061fb821005"
  destinationCIDR = "172.31.32.0/20"
}

```

### outputs.tf
``` terraform 
output "cgwTagName" {
  description = "cgwTagName"
  value       = module.tgw-cgw-conn.cgwTagName
}

output "tgwTagName" {
  description = "tgwTagName"
  value       = module.tgw-cgw-conn.tgwTagName
}

```

- - -

# Argument Reference
|Argument|Description|Option|
|:--|:--|:--:|
| cgwIP | On-premise측 접속 IP주소 (공인 IP) | Required 
| cgwASN | On-premise에서 다루는 vpn 장비의 ASN. <br> 없는 경우 default = 65000 | Optional
| attachVpcId | 연결하고자 하는 VPC의 id | Required 
| attachVpcSubnetIds | 연결하고자 하는 VPC의 Subnet id들 | Required 
| rtbId | 갱신하려는 VPC의 routing table | Required 
| destinationCIDR | On-premise측 private network cidr | Required 

>❗ 하나의 가용영역 당 1개의 서브넷만 연결할 수 있다.<br>
단, 1개의 서브넷이 연결되면 소속된 가용영역의 모든 서브넷들은 vpn 연결이 된다.
- - -

# Attribute Reference
|Argument|Description|Value|
|:--|:--|:--|
|cgwID | ID of the customer gateway | module.<module 이름>.cgwID
|cgwTagName | Tag name of the customer gateway | module.<module 이름>.cgwTagName
|tgwID | ID of transit gateway | module.<module 이름>.tgwID
|tgwTagName | Tag name of transit gateway | module.<module 이름>.tgwTagName
|vpnConnID | ID of vpn connection | module.<module 이름>.vpnConnID
|rtbID | ID of routing table | module.<module 이름>.rtbID

## 예시

``` hcl
output "원하는 이름" {
  description = "설명"
  value       = module.tgw-cgw-conn.<Attribute 값 (tgwID, rtbID 등)>
}
```

- - -

# Import

repository의 modules 디렉토리를 통째로 원하는 VM에 넣는다. 

본인의 main.tf파일에서 위 예시를 확인하여 module을 사용한다.

#### Dictionary Tree
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
