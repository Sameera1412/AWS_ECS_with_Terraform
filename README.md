# AWS_ECS_with_Terraform
This repo contains end to end Terraform code to create AWS ECS Cluster with Elastic Load Balancing.
**main.tf contains below blocks:**
terraform
provider
**VPC.tf contains below resources:**
aws_VPC
aws_subnet
aws_internet_gateway
aws_route_table
aws_route_table_association
**SG.tf contains below resources:**
aws_security_group
ingress
egress
**iamrole.tf contains below resources:**
aws_iam_role
aws_iam_policy
aws_iam_role_policy_attachment
**lb.tf contains below resources:**
aws_lb
aws_lb_listener
aws_lb_target_group
**ECSNGINX.tf contains below resources:**
aws_ecs_cluster
aws_ecs_task_definition
aws_ecs_service
