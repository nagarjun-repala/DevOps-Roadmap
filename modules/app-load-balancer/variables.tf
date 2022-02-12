variable "alb_name" {
  type = string
  description = "Name of the application load balancer"
}

variable "health_check_path" {
    type = string
    description = "Health check path"
    default = "/"
  
}


variable "vpc_id" {
    type = string
    description = "VPC ID"
}

variable "target_id" {
    type = string
    description = "Instance ID or instance ip(if set target type as ip)"
  
}

variable "target_type" {
    type = string
    description = "Type of the target instance or IP"
    default = "instance"
  
}

variable "instance_target_port" {
    type = number
    description = "Target port on instance"
    default = 80
  
}

variable "is_internal" {
    type = bool
    description = "Set to false for external load balancer"
    default = false
  
}

variable "load_balancer_subnet_ids" {
    type = list(string)
    description = "Subnet ID's for Load Balancer"
  
}

variable "enable_cross_zone_load_balancing" {
    type = bool
    description = "Enable cross zone load balancing"
    default = true
  
}