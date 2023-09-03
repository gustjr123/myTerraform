# myTerraform
나만의 테라폼 코드들

개인적으로 테라폼 관련한 코드를 정리한 레포지토리

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

## 명령어

### 실행 
``` 
terraform init
sudo terraform plan
sudo terraform apply -auto-approve
```

### 삭제
```
sudo terraform destroy -auto-approve
```

- - -

# 참고
#### 기본적으로 window와 Unix/Linux의 줄 바꿈 문자가 다르기 때문에 파일 자체를 서버에 올려서 사용해야한다.

"local-exec"실행 하면서 EOT 부분에서 에러가 발생하면 보통 이 문제다. 

Window : CR+LF

Unix/Linux : LF
