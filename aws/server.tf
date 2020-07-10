resource "aws_instance" "cam" {
  ami           = var.ami
  ebs_optimized = false
  instance_type = var.instance_type
  monitoring    = true
  key_name      = var.key_pair
  subnet_id     = aws_subnet.subnet-public.id

  vpc_security_group_ids = [
    aws_security_group.cam-sg.id,
  ]

  tags = {
    Name = var.instance_name
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_vol_size
  }
}

resource "aws_eip" "cam-eip" {
  vpc      = true
  instance = aws_instance.cam.id
}