# 요약

VPN 연결을 위한 Transit gateway와 customer gateway 생성 및 연결 Terraform

- - -

# Argument Reference
## Required

**1. cgwIP - string**

    On-premise측의 vpn 게이트웨이가 되는 customer 게이트웨이의 public IP 주소 (IPv4)

**2. cgwASN - number**
 
    customer gateway의 BGP ASN (기업의 경우 자체적으로 운용하는 ASN 값을 넣을 것)

    ❗ 테스트에서는 Openswan을 통한 VM 과의 연결을 진행했으므로 65000 값으로 원하는 값을 넣어서 진행했음.

    default : 65000

    range : 1 ~ 2147483647

**3. attachVpcId - string**

    transit gateway와 연결할 VPC ID

**4. attachVpcSubnetIds - list(string)**

    transit gateway와 연결할 vpc의 subnet id들

    ❗ 예. ["subnet-abc123456", "subnet-bdc123456789"]
    
    ❗ 주의. 하나의 가용영역 당 1개의 서브넷만 연결할 수 있다. 단, 1개의 서브넷이 연결되면 소속된 가용영역의 모든 서브넷들은 vpn 연결이 된다.

**5. rtbId - string**

    transit gateway와 연결되어서 갱신해야할 routing table의 id

**6. destinationCIDR - string**

    On-premise측 private network의 cidr

    ❗ 예. "192.168.0.0/21"

## Optional

**7. cgwTagName - string**

    customer gateway of Tag name

    default : myCGW

**8. cgwType - string**

    customer gateway of Type

    default : ipsec.1

**9. vpnConnTagName - string**

    vpn connection of Tag Name

    default : vpn_attach

**10. vpcAttachTagName - string**

    tgw to vpc Attachment of Tag Name

    default : tgw_vpc

- - -

# Attribute Reference

- cgwID = ID of the customer gateway
- cgwTagName = Tag name of the customer gateway
- tgwID = ID of transit gateway
- tgwTagName = Tag name of transit gateway
- vpnConnID = ID of vpn connection
- rtbID = ID of routing table
