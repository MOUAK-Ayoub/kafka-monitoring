data "aws_ssm_parameter" "ami-linux-monitoring" {
  provider = aws.region-monitoring
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "key-monitoring" {
  provider   = aws.region-monitoring
  key_name   = "monitoring"
  public_key = file("./id_rsa.pub")
}

resource "aws_instance" "monitoring-master" {

  provider      = aws.region-monitoring
  ami           = data.aws_ssm_parameter.ami-linux-monitoring.value
  instance_type = var.instance-type

  key_name = aws_key_pair.key-monitoring.key_name

  vpc_security_group_ids = [aws_security_group.sg-monitoring.id]
  subnet_id              = aws_subnet.subnet_monitoring.id

  associate_public_ip_address = true

  tags = {
    Name = "administration"
  }

  depends_on = [aws_main_route_table_association.vpc_route_asso_monitoring]

}

