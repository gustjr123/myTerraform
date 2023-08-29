## 요약

NAT Gateway의 금액이 매우 많이 들기 때문에 EC2 인스턴스를 NAT 서버로 활용한다.

- - -

## 설정 할 것

1. vpc_id

nat Instance를 생성하고자 하는 VPC의 ID

2. vpc_cidr_ipv4

vpc의 CIDR 값 (IP 주소 대역)

3. subnet_id

nat Instance가 위치할 subnet ID

※ 참고로 nat instance는 외부 인터넷과 연결되어야 하므로 public subnet에 위치해야 한다.

4. pvt_subnet_ids

nat Instance를 통해 인터넷과 통신하고자 하는 private subnet ID들. 

여러개 일 수 있기 때문에 배열('[]') 형태로 사용하면 된다.

5. ssh_key

nat Instance의 ssh_key 키페어.

ssh_key값은 테라폼 실행할 때 입력한다. (실행 부분 참고)

- - -

## 실행

리소스 생성
```
terraform apply -auto-approve -var ssh_key=<ssh key ID>
```

리소스 삭제
```
terraform destroy -auto-approve -var ssh_key=<ssh key ID>
```