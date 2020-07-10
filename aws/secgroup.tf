# server security group
resource "aws_security_group" "cam-sg" {
  name        = "cam-sg"
  description = "cam-sg"
  vpc_id      = aws_vpc.cam.id
}

# inbound ssh access
resource "aws_security_group_rule" "ssh-in" {
  type        = "ingress"
  description = "ssh access"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = var.ssh_cidr_blocks

  security_group_id = aws_security_group.cam-sg.id
}

# https inbound
resource "aws_security_group_rule" "https-in" {
  type        = "ingress"
  description = "https access"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.cam-sg.id
}

# https outbound
resource "aws_security_group_rule" "https-out" {
  type        = "egress"
  description = "https access"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.cam-sg.id
}

# http outbound
resource "aws_security_group_rule" "http-out" {
  type        = "egress"
  description = "http access"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.cam-sg.id
}