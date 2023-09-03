# 개요

Openswan 설치 및 설정하는 Terraform

AWS의 Transit Gateway와 연결하는 것을 기준으로 작성 됨.

- - -

# 각 요소 설명

variable "leftid" : "106.253.56.124" (온프레미스의 공인 IP 주소)

variable "right1" : "3.34.151.216" (AWS의 tunnel1 공인 IP 주소 <- 프로젝트에서 이 부분 수정)

variable "right2" : "15.165.192.64" (AWS의 tunnel2 공인 IP 주소 <- 프로젝트에서 이 부분 수정)

variable "leftsubnet" : "192.168.0.0/21" (온프레미스의 VPC CIDR)

variable "rightsubnet1" : "10.4.0.0/16" (AWS의 VPC CIDR)

variable "rightsubnet2" : "10.4.0.0/16" (AWS의 VPC CIDR)

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
