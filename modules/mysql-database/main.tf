terraform {

  required_version = ">= 0.12"

}

resource "aws_db_subnet_group" "db-subnet-group" {

  name = "${var.identifier_name}-subnet-group"
  subnet_ids = var.db_subnet_ids
  tags = {
    Name = "${var.identifier_name}-subnet-group"
  }
  
}

resource "aws_security_group" "db-security-group" {

  name        = "${var.identifier_name}-sg"
  description = "attaching to db"
  vpc_id      = var.vpc_id
  ingress {
    description = "any cidr"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.webserver_sg_id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.identifier_name}-sg"
  }

}

resource "aws_db_instance" "mysql" {

  allocated_storage      = var.storage
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.identifier_name
  name                   = var.name
  username               = var.user
  password               = var.password
  storage_type           = var.storage_type
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.db-security-group.id]
  skip_final_snapshot    = var.skip_final_snapshot

}

resource "aws_secretsmanager_secret" "secret-name" {
  name                    = "${var.identifier_name}-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db-secrets-manager" {
  depends_on = [
    aws_db_instance.mysql
  ]
  secret_id     = aws_secretsmanager_secret.secret-name.id
  secret_string = "${aws_db_instance.mysql.endpoint};${var.user};${var.password};${var.name};"

}