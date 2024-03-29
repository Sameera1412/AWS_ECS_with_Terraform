#CREATING CLUSTER
resource "aws_ecs_cluster" "ECS_CLUSTER" {
    name = "ECS_CLUSTER_NGINX"
}

#CREATING TASK DEFINITION

resource "aws_ecs_task_definition" "ECS_TD" {
  family                   = "ECS_TD"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }
  execution_role_arn       = aws_iam_role.test_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "nginx",
    "image": "public.ecr.aws/nginx/nginx:mainline-alpine3.18-perl",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "appProtocol": "http",
        "protocol": "tcp"
      }
    ]
  }
]
TASK_DEFINITION
}


#CREATING SERVICE

resource "aws_ecs_service" "ECS_Service" {
  name            = "ECS_Service"
  cluster         = aws_ecs_cluster.ECS_CLUSTER.id
  task_definition = aws_ecs_task_definition.ECS_TD.arn
  desired_count = 1
  launch_type = "FARGATE"
  #iam_role = aws_iam_role.test_role.arn
  depends_on = [aws_iam_policy.policy, aws_subnet.public, aws_subnet.public1]
  
  network_configuration {
    
    security_groups = [aws_security_group.allow_all_traffic.id]
    subnets = [aws_subnet.public.id, aws_subnet.public1.id]
    assign_public_ip = true
    
    
  }
  
  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = "nginx"
    container_port   = 80
  }  
}