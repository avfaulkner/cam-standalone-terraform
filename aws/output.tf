output "cam_instance" {
  value = {
    instance_name = var.instance_name
    id            = aws_instance.cam.id
    private_ip    = aws_instance.cam.private_ip

    private_dns = aws_instance.cam.private_dns

    public_ip = aws_eip.cam-eip.public_ip
  }
}
