data "aws_availability_zones" "available" { }

data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
}