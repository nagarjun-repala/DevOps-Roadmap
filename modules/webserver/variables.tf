variable "keypair" {
    type = string
    description = "keypair for ec2"
  
}

variable "sshpubkey" {
    type = string
    description = "your own public key"
  
}

variable "ami_id" {
    type = string
    description = "AMI ID for EC2 instance"
  
}

variable "instance_type" {
    type = string
    description = "Type of the instance"
    default = "t2.micro"
  
}

variable "subnet_id" {
    type = string
    description = "Subnet for webserver to be deployed in"
  
}

variable "webserver_name" {
    type = string
    description = "Name tag for webserver"
  
}

variable "user_data_filename" {
    type = string
    description = "Name of the script file"
  
}

variable "vpc_id" {

    type = string
    description = "VPC ID"
  
}

variable "vpc_cidr" {

    type = string
    description = "VPC CIDR"
  
}

variable "lb_sg_id" {

    type = string
    description = "Load balancer SG ID"
  
}

variable "secrets_manager_arn" {
    type = string
    description = "Secret manager arn"
  
}

