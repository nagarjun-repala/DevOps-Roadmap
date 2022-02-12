variable "identifier_name" {
    type = string
    default="lamp-db"
  
}
variable "name" {
  type        = string
  description = "db name"
  sensitive   = true

}

variable "user" {
  type        = string
  description = "db username"
  sensitive   = true

}

variable "password" {
  type        = string
  description = "db password"
  sensitive   = true

}

variable "engine_version" {
  type= string
  description = "Engine version"
  default = "8.0.23"
  
}

variable "instance_class" {
  type = string
  description="Storage class for the DB"
  default = "db.t2.micro"
  
}

variable "storage_type" {
  type = string
  description="Storage type for DB"
  default = "gp2"
  
}


variable "storage" {
  type = string
  description = "Storage for DB"
  default = 20
  
}

variable "vpc_id" {
  type = string
  description = "VPC ID"  
}

variable "webserver_sg_id" {
  description = "Webserver security group id"
  
}

variable "skip_final_snapshot" {
  type= string
  description = "Checks whether the snapshot is created or not hile deleting the DB instance"
  default = true
  
}

variable "db_subnet_ids" {
  type = list(string)
  description = "Subnet ID's for DB to be deployed in"
  
}

