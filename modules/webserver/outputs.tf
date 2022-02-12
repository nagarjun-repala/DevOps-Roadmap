output "webserver_sg_id" {
    value = aws_security_group.webserver-security-group.id
    depends_on = [
      aws_security_group.webserver-security-group
    ]

}

output "instance_id" {
    value = aws_instance.webserver.id
    depends_on = [
      aws_instance.webserver
    ]
  
}