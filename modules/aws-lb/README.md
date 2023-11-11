## 요약

귀찮으니 ALB와 Target group을 한번에 생성해서 연결하는 작업을 module화 시킨다

(단순히 Application Load Balancer로 생성하여 Target group을 생성하여 인스턴스를 삽입하는 과정이다.)

(필요에 따라 ALB가 아닌 NLB나 Target group의 type을 인스턴스가 아닌 IP주소 등으로 교체하여 사용할 것.)

- - -

## 필수 설정

**1. vpc_id**

    VPC의 ID

**2. lb-vpc_subnet_ids**

    Load Balancer가 위치할 subnet id들 

    ※ 외부 ip와 연결하려면 public subnet에 연결해야함 

**3. security_groups**

    LoadBalancer에 할당되는 보안그룹 id들

## 선택 설정

**4. existing_instance_ids**

    미리 만들어놓은(target group에 연결할) 인스턴스 ID들

**5. tg-name**

    Target group의 Name 지정 변수

**6. lb-name**

    LB의 Name 지정 변수

**7. lb-type**

    LB의 Type지정 변수 (※주의. application밖에 안된다. 다른 건 설정이 다르다)

    Default : application

- - -

## 추가사항 

본 내용은 참고사항으로 사용하고 본격적으로 사용하기 위해서는 나름의 커스터마이징이 필요함.

