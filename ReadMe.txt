Simple AWS network infrastructure by using Terraform

Following resources are created by using above code:
-VPC
-Public and Private Subnets
-Internet Gateway
-NAT Gateway
-Main and Custom Route Tables
-Instance in public as well as private subnet

This network infrastructure allows :
- ingress and egress internet traffic via internet gateway to EC2 instance in public subnet
- egress traffic to internet via NAT gateway from private subnet
- local traffic in VPC (10.10.0.0/16) via local routes

Steps to run the code :
1- Configure IAM user using AWS CLI
2- Copy terraform code in one folder
3- Open VS Code in that folder and open terminal in VS code
4- Run command 'terraform init'
5-After that run command 'terraform plan'
6-Lastly run command 'terraform apply' and give 'yes' in approval

Resources will be created by following above steps

7- To clean up run command 'terraform destroy' this will delete all the created resources