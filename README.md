
# Two tier AWS network infrastructure by using Terraform



## Following resources are created by using above code:

- VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Main and Custom Route Tables
- Instance in public as well as private subnet
- Security Group
- Key-Pair



## This network infrastructure allows :

- Ingress SSH, HTTP, HTTPS and egress all traffic via internet gateway to EC2 instance in public subnet
- Egress traffic to internet via NAT gateway from private subnet
- Local traffic in VPC (10.10.0.0/16) via local routes

## Steps to run the code :

1. Configure IAM user using AWS CLI
2. Clone **Two-tier-network-infrastructure-by-using-Terraform** repository into your local
4. Run below command, this will download required provider plugins
```bash
terraform init
```
5. After that run below command, this will provide brief information of resources to be created
```bash
terraform plan
```
6. Edit your key-pair name in 'terraform.tfvars' file. Then run bewlo command, it will create planned resources in AWS
```bash
terraform apply
```
7. While connecting to instance change key permission using 'chmod 400 {key name}' if you are using Linux or MacOS
8. To change key permission for Windows, follow this youtube video:
https://www.youtube.com/watch?v=OTwEfZP1nb8



    
## To Clean the  infrastructure

- To clean up, run below command, this will delete all the created resources
```bash
terraform destroy
```







