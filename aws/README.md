# AWS 리소스 테라폼 적용 

본 코드는 AWS의 Amazone Linux 2에서 테스트되었음을 미리 말합니다.

따라서 특정 명령어 또는 프로그램 상호호환성 문제가 생길 수 있습니다.

- - -

# 기본 공통 세팅

* VPC DNS 호스트 이름 활성화
  1. 사용할 VPC, 작업, VPC 설정편집
  2. DNS 설정, DNS 호스트 이름 활성화 체크
  3. 확인

* Subnet 퍼블릭 IP 자동할당 활성화
  1. 사용할 public subnet, 작업, 서브넷 설정 편집
  2. 자동할당 IP 설정, 퍼블릭 IPv4 주소 자동 할당 활성화 체크
  3. 저장

* VPC IGW(internet gateway) 연결
  1. VPC - IGW 생성
  2. 사용할 VPC 연결
  3. default rtb(routing table)에 라우팅 추가 (from 0.0.0.0/0 to IGW)
  4. (선택사항) 사용할 rtb 생성 및 라우팅 추가 

- - -

# aws 2.X버전 설치

1. 설치
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
reboot
```

※ 혹시 모를 상황에 대비하여 설치 후 리부트 해준다.

2. Access Key 설정
```
aws configure

# AWS Access Key ID [None]: <AccessKey ID>
# AWS Secret Access Key [None]: <AccessKey Secret Key>
# Default region name [None]: ap-northeast-2
# Default output format [None]: json
```

- - -

