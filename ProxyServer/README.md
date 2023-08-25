# 개요
개인용 프록시 서버 생성을 위한 Terraform 구성
Terraform을 활용해서 squid 설치 및 구성까지 자동화

# 활용법
## Terraform 설치 (AWS EC2 Amazon Linux 2 기준)
### 설치
```
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum update -y
sudo yum -y install terraform
terraform version
```

### 자동완성
```
terraform -install-autocomplete
```

### 파일 다운로드 후 명령어
``` 
terraform init
terraform plan
sudo terraform apply -auto-approve

sudo systemctl restart squid
```

# 파이어폭스 브라우저 프록시 서버 설정
1. 우측상단 <석삼> 클릭 
2. 설정 
3. 일반 탭 스크롤 최하단 네트워크 설정 <설정> 클릭 
4. 수동 프록시 설정, http프록시에 프록시서버 IP, PORT = 3128, HTTPS에도 이 프록시 설정 체크, 확인
5. 브라우저에서 내 아이피 검색 후 프록시서버의 IP로 나오는지 확인