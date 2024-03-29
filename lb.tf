resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all_traffic.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public1.id]
 }

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}


resource "aws_lb_target_group" "example" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

output "lb_dns" {
 value = aws_lb.test.dns_name
}