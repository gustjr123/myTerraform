# myTerraform
나만의 테라폼 코드들

개인적으로 테라폼 관련한 코드를 정리한 레포지토리

- - -

# 활용법
## Terraform 설치 (AWS EC2 Amazon Linux 2 기준)
### 설치
``` bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum update -y
sudo yum -y install terraform
terraform version
```

### 자동완성
``` bash
terraform -install-autocomplete
```

## 명령어

### 실행 
``` bash
terraform init
sudo terraform plan
sudo terraform apply -auto-approve
```

### 삭제
``` bash
sudo terraform destroy -auto-approve
```

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

# aws 2.X버전 설치

1. 설치
``` bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
reboot
```

※ 혹시 모를 상황에 대비하여 설치 후 리부트 해준다.

2. Access Key 설정
``` bash
aws configure

# AWS Access Key ID [None]: <AccessKey ID>
# AWS Secret Access Key [None]: <AccessKey Secret Key>
# Default region name [None]: ap-northeast-2
# Default output format [None]: json
```

- - -

# 참고
#### 기본적으로 window와 Unix/Linux의 줄 바꿈 문자가 다르기 때문에 파일 자체를 서버에 올려서 사용해야한다.

"local-exec"실행 하면서 EOT 부분에서 에러가 발생하면 보통 이 문제다. 

Window : CR+LF

Unix/Linux : LF
