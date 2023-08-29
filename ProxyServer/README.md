# 개요
개인용 프록시 서버 생성을 위한 Terraform 구성

Terraform을 활용해서 squid 설치 및 구성까지 자동화

- - -

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

## 실행 명령어

### 기본 실행 (하단 추가사항의 사용자로 접근)
``` 
terraform init
sudo terraform plan
sudo terraform apply -auto-approve
```

### 내 아이피 할당 실행 (내 아이피로 접근)
``` 
terraform init
sudo terraform plan
sudo terraform apply -auto-approve -var myIP=<내 아이피>
```

## 삭제
```
sudo terraform destroy -auto-approve
```

- - -

# 파이어폭스 브라우저 프록시 서버 설정
1. 우측상단 <석삼> 클릭 
2. 설정 
3. 일반 탭 스크롤 최하단 네트워크 설정 <설정> 클릭 
4. 수동 프록시 설정, http프록시에 프록시서버 IP, PORT = 3128, HTTPS에도 이 프록시 설정 체크, 확인
5. 브라우저에서 내 아이피 검색 후 프록시서버의 IP로 나오는지 확인

### 추가로 크롬 브라우저는 기본 시스템 프록시 설정을 사용
### 새 프로필을 사용하여 Chrome을 시작하고 Squid 서버에 연결하려면 다음 명령을 사용합니다.

**Linux**
```
/usr/bin/google-chrome \
    --user-data-dir="$HOME/proxy-profile" \
    --proxy-server="http://SQUID_IP:3128"
```

**Window**
```
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" ^
    --user-data-dir="%USERPROFILE%\proxy-profile" ^
    --proxy-server="http://SQUID_IP:3128"
```

- - -

# 참고
#### 기본적으로 window와 Unix/Linux의 줄 바꿈 문자가 다르기 때문에 파일 자체를 서버에 올려서 사용해야한다.

"local-exec"실행 하면서 EOT 부분에서 에러가 발생하면 보통 이 문제다. 

Window : CR+LF

Unix/Linux : LF

- - -

# + 추가사항 : ID, Password로 사용자 인증과정을 추가하도록 했음. 

## 초기 사용자
ID : default

PASSWORD : default

## 사용자 추가
```
printf "USERNAME:$(openssl passwd -crypt PASSWORD)\n" | sudo tee -a /etc/squid/htpasswd

sudo systemctl restart squid
```

