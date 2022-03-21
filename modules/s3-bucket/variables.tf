variable "env_type" {
    type = string
    validation {
      condition = contains(["dev", "test", "uat", "prod"], var.env_type)
      error_message = "Please add valid environment type"
    }
  
}