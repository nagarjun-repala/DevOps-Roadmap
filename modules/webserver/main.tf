resource "aws_key_pair" "keypair" {
  key_name   = var.keypair
  public_key = var.sshpubkey
}



resource "aws_instance" "webserver" {


  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.keypair
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2-instance-profile.name
  subnet_id              = var.subnet_id
  user_data              = file(var.user_data_filename)
  tags = {
    Name = var.webserver_name
  }

}


resource "aws_security_group" "webserver-security-group" {



  name        = "${var.webserver_name}-sg"
  description = "attaching to ubuntu ec2"
  vpc_id      = var.vpc_id
  ingress {
    description = "ssh within the vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description     = "any cidr"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.lb_sg_id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.webserver_name}-sg"
  }

}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "${var.webserver_name}-instance-profile"
  role = aws_iam_role.ec2-instance-role.name
}

resource "aws_iam_role" "ec2-instance-role" {

  name = "${var.webserver_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "secrets-manager-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "secretsmanager:GetResourcePolicy",
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret",
            "secretsmanager:ListSecretVersionIds"
          ]
          Effect   = "Allow"
          Resource = var.secrets_manager_arn
        },
      ]
    })
  }
}