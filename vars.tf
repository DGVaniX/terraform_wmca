variable "is_dev" {
  description = "Is this a dev build? (yes/no)"
  type        = string
  default     = "yes"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  default     = "ami-057b6e529186a8233"
}

variable "instance_type" {
  description = "The type of the instance"
  default     = "t2.micro"
}

variable "cidr_block_for_ingress" {
  description = "Cidr block for the ingress"
  default     = "0.0.0.0/0"
}

variable "the_region" {
  description = "Selected region"
  default     = "eu-west-1"
}
