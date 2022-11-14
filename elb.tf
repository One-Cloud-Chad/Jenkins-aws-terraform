module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-jenkins"

  subnets         = [aws_subnet.public-subnet-1.id]
  security_groups = [aws_security_group.sg_allow_jenkins.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:80/login"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = 1
  instances           = [aws_instance.jenkins-ci-vm.id]

}