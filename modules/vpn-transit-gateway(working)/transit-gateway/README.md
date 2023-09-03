1. main.tf를 aws 계정과 연동된 instance에 복사한다.
main.tf에서 각 리소스들의 subnet 및 IP주소 수정 필요.


2. terraform 설치
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
which terraform
terraform version
terraform -install-autocomplete


3. 실행
terraform init
terraform plan
terraform apply -auto-approve

[제거]