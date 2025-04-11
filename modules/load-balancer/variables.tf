# modules/load-balancer/variables.tf

variable "compartment_id" {
  description = "The OCID of the compartment where the load balancer will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet OCIDs where the load balancer will be placed"
  type        = list(string)
}

variable "lb_name_prefix" {
  description = "Prefix for the load balancer name"
  type        = string
  default     = "afid"
}

variable "lb_min_bandwidth" {
  description = "Minimum bandwidth for the flexible shape load balancer (in Mbps)"
  type        = number
  default     = 10
}

variable "lb_max_bandwidth" {
  description = "Maximum bandwidth for the flexible shape load balancer (in Mbps)"
  type        = number
  default     = 100
}

variable "is_private" {
  description = "Whether the load balancer should be private (true) or public (false)"
  type        = bool
  default     = false
}

variable "network_security_group_ids" {
  description = "List of network security group OCIDs to associate with the load balancer"
  type        = list(string)
  default     = []
}

variable "reserved_ip_id" {
  description = "OCID of a reserved public IP to assign to the load balancer"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}
