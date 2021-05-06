resource "aws_elb" "wordpress-lb" {
    name = "wordpress-load-balancer"
 #   availability_zones = [ data.aws_availability_zones.current.names[0], data.aws_availability_zones.current.names[1] ]
    security_groups = [ aws_security_group.lb_sg.id ]
    subnets = [ aws_subnet.public.id ]
    listener {
      lb_port = 80
      lb_protocol = "http"
      instance_port = 80
      instance_protocol = "http"
    }
health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    target              = "TCP:80"
    timeout             = 3
    interval            = 30
  }

  instances                   = [aws_instance.wordpress-1.id, aws_instance.wordpress-2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = " wordpress load balancer"
  }
}
