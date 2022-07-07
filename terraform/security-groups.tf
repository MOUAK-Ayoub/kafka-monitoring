
resource "aws_security_group" "sg-monitoring" {

  provider    = aws.region-master
  vpc_id      = aws_vpc.aws_vpc_master.id
  name        = "jenkins-master-sg"
  description = "Allow ssh to the master  and 8080   and 443 port traffic from alb and all trafic from the worker"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external-ip]
  }
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-alb.id]

  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-alb.id]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.1.0/24"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

