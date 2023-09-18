# 개요
개인용 프록시 서버 생성을 위한 Terraform 구성

Terraform을 활용해서 squid 설치 및 구성까지 자동화

- - -

# Example Usage

### main.tf
``` terraform
module "squid" {
  source = "./modules/proxy-server-squid"

  IP       = "127.0.0.1"
  user     = "user1"
  password = "userpw"
}
```

### outputs.tf
``` terraform 
output "IP" {
  description = "access IP"
  value       = module.squid.IP
}

output "account" {
  description = "access account user"
  value       = module.squid.account
}

output "password" {
  description = "access account password"
  value       = module.squid.password
}
```

- - -

# Argument Reference
|Argument|Description|Option|
|:--|:--|:--:|
|IP | 프록시 서버에 접속을 허용할 IP (공인 IP) | Optional
|user | 프록시 서버에 접속을 허용할 계정의 user | Optional
|password | 서버 접속이 허용된 계정의 password | Optional

- - -

# Attribute Reference
|Argument|Description|Value|
|:--|:--|:--|
|IP | 접속을 허용할 IP | module.<module 이름>.IP
|account | 접속을 허용할 계정 | module.<module 이름>.account
|password | 계정의 password | module.<module 이름>.password

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

- - -

# 기타 참고사항

## 파이어폭스 브라우저 프록시 서버 설정
1. 우측상단 <석삼> 클릭 
2. 설정 
3. 일반 탭 스크롤 최하단 네트워크 설정 <설정> 클릭 
4. 수동 프록시 설정, http프록시에 프록시서버 IP, PORT = 3128, HTTPS에도 이 프록시 설정 체크, 확인
5. 브라우저에서 내 아이피 검색 후 프록시서버의 IP로 나오는지 확인

#### ※ 추가로 크롬 브라우저는 기본 시스템 프록시 설정을 사용
#### ※ 새 프로필을 사용하여 Chrome을 시작하고 Squid 서버에 연결하려면 다음 명령을 사용합니다.

**Linux**
``` bash
/usr/bin/google-chrome \
    --user-data-dir="$HOME/proxy-profile" \
    --proxy-server="http://SQUID_IP:3128"
```

**Window**
``` bash
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" ^
    --user-data-dir="%USERPROFILE%\proxy-profile" ^
    --proxy-server="http://SQUID_IP:3128"
```

## 초기 사용자
ID : default

PASSWORD : default

## 사용자 추가
``` bash
printf "USERNAME:$(openssl passwd -crypt PASSWORD)\n" | sudo tee -a /etc/squid/htpasswd

sudo systemctl restart squid
```