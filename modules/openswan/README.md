# 개요

Openswan 설치 및 설정하는 Terraform

❗ AWS의 Transit Gateway와 연결하는 것을 기준으로 작성 됨.
❗ (예시) AWS의 (onPrem) Instance : VPC(10.0.0.0/16)
❗ (예시) AWS의 (cloud) Instance : VPC(172.31.0.0/16)

- - -

# 각 요소 설명

variable "leftid" : "3.34.191.49" (온프레미스의 공인 IP 주소)

variable "right1" : "3.34.151.216" (AWS의 tunnel1 공인 IP 주소 <- 프로젝트에서 이 부분 수정)

variable "right2" : "15.165.192.64" (AWS의 tunnel2 공인 IP 주소 <- 프로젝트에서 이 부분 수정)

variable "leftsubnet" : "10.0.0.0/16" (온프레미스의 VPC CIDR)

variable "rightsubnet1" : "172.31.0.0/16" (AWS의 VPC CIDR)

variable "rightsubnet2" : "172.31.0.0/16" (AWS의 VPC CIDR)

variable "psk1" : "key값" (tunnel1의 Pre-shared key 값 <- 이 부분 수정)

variable "psk2" : "key값" (tunnel2의 Pre-shared key 값 <- 이 부분 수정)

#### ※ 위 값들은 이미 삭제된 리소스들의 값이므로 예시로 참고만 할 것.

- - -

## terraform apply
``` terraform
terraform init 
terraform plan 
terraform apply -auto-approve
``` 

## terraform destroy
``` terrafom
terraform destroy -auto-approve
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
