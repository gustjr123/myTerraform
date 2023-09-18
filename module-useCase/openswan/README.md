# 개요

Openswan Terraform 예제

- - -

# Example Usage

### main.tf
``` terraform
module "myOpenswan" {
  source = "./modules/openswan"

  leftid       = "3.34.191.49"
  right1       = "3.39.17.109"
  right2       = "13.209.1.173"
  leftsubnet   = "10.0.0.0/16"
  rightsubnet1 = "172.31.0.0/16"
  rightsubnet2 = "172.31.0.0/16"
  psk1         = "<PSK>"
  psk2         = "<PSK>"
}
```

- - -

# Argument Reference
|Argument|Description|Option|
|:--|:--|:--:|
|leftid       | 온프레미스의 공인 IP 주소 | Required
|right1       | AWS의 tunnel1 공인 IP 주소 | Required
|right2       | AWS의 tunnel2 공인 IP 주소 | Required
|leftsubnet   | 온프레미스의 VPC CIDR | Required
|rightsubnet1 | AWS의 VPC CIDR | Required
|rightsubnet2 | AWS의 VPC CIDR | Required
|psk1         | tunnel1의 Pre-shared key 값 | Required
|psk2         | tunnel2의 Pre-shared key 값 | Required

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

- - -

# 주의사항

## conf 파일 및 local-exec 리소스 관련
#### 기본적으로 window와 Unix/Linux의 줄 바꿈 문자가 다르기 때문에 파일 자체를 서버에 올려서 사용해야한다.

module의 구성을 확인하면 openswan이라는 오픈소스를 설정하는 것이기 때문에 특성상 local-exec 리소스와 templatefile을 활용한다.

"local-exec"실행 하면서 EOT 부분에서 에러가 발생하면 보통 이 문제다. 

Window : CR+LF

Unix/Linux : LF

#### ※ 만약에 ipsec 실행 구문 부분에서 ipsec 실행이 안된다면 conf파일도 위와 같은 문제가 발생한 것.
#### ※ module의 conf.tftpl과 sysctl.tftpl을 LF 모드로 저장해서 재실행해야한다.
