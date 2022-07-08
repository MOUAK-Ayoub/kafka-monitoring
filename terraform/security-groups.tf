
resource "aws_security_group" "sg-monitoring" {

  provider    = aws.region-monitoring
  vpc_id      = aws_vpc.aws_vpc_monitoring.id
  name        = "monitoring-sg"
  description = "Allow ssh to the monitoring instance and 9090   and 8000 port traffic to the UI "
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external-ip]
  }
  ingress {
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    cidr_blocks = [var.external-ip]

  }
  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    cidr_blocks = [var.external-ip]
  }
  ingress {
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    cidr_blocks = [var.external-ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

