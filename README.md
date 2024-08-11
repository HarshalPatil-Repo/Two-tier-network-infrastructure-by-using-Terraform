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
