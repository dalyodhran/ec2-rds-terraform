resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my-ssh-key" {
  key_name = "my-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "ec2instance" {
  instance_type = "t2.micro"
  ami = "ami-0ab193018f3e9351b"
  subnet_id = aws_subnet.private-subnet-1.id
  security_groups = [aws_security_group.security-group.id]
  key_name = aws_key_pair.my-ssh-key.key_name
  disable_api_termination = false
  ebs_optimized = false
  user_data = data.template_file.user_data.rendered
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  root_block_device {
    volume_size = "8"
    delete_on_termination = "true"
    volume_type = "gp2"
  }
}

resource "aws_instance" "ec2jumphost" {
  instance_type = "t2.micro"
  ami = "ami-0ab193018f3e9351b"
  subnet_id = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.security-group.id]
  key_name = aws_key_pair.my-ssh-key.key_name
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "8"
    delete_on_termination = "true"
    volume_type = "gp2"
  }
}

resource "aws_eip" "jumphost" {
  instance = aws_instance.ec2jumphost.id
  domain   = "vpc"
}