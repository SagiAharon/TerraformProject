
# The resource group name
variable "rg_name" {
  type = string
  //default       = "Production"
  description   = "The name of my production environment."
}

# The resource group location 
variable "rg_location" {
  type = string
  //default       = "westeurope"
  description   = "Location of the resource group."
}

# The SSH Port 
variable "SSH_port" {
   type = number
   description = "Port that you want to connect with your VMs"
   default     = 22
}

# The Application Port
variable "Application_port" {
   type = number
   description = "Port that you want to connect with your VMs"
   default     = 8080
}

# number of times to do something
variable "Timesof" {
   type = number
   description = "Count of VMs and interfaces"
}

variable "Size" {
  type = string
  description = "The VMs size of the current workspace"
  
}

variable "LBName" {
  type = string
  description = "The Name of the current workspace"
}

variable "NSGname" {
  type = string
  description = "The NSGname of the current workspace"
}

variable "DBsubName" {
  type = string
  description = "The DBsubnet of the current workspace"
}

variable "DBName" {
  type = string
  description = "The name of the db of the current workspace"
}

variable "DifIps" {
  type = string
  description = "The ip range of Vnet in current workspace"
}

variable "SubnetRange" {
  type = string
  description = "The ip range of Vnet in current workspace"
}

variable "SubnetRangeDB" {
  type = string
  description = "The ip range of Vnet in current workspace"
}