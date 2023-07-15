resource "aws_db_instance" "db" {
  engine = "postgres"
  engine_version = "14"
  instance_class = "db.t3.micro"
  allocated_storage = 5
  storage_type = "gp2"
  identifier = "my-db"
  db_name = "my_db"
  username = "posgresuser"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.example.key_id
  port = 5432
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  availability_zone = data.aws_availability_zones.available.names[0]
  skip_final_snapshot = true
}