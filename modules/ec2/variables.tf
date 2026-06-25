variable "instance_name" {
    description = "Name of the EC2 instance"
    type        = string
    default     = "terra-auto-server"
}

variable "ec2_volume_size" {
    description = "Size of the EC2 instance volume in GB"
    type        = number
    default     = 10
}

variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-01a00762f46d584a1"
}

variable "env" {
  description = "Environment for the EC2 instance"
  type        = string
}

variable "ec2_instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Instance type must be one of: t2.micro, t2.small, t2.medium, t3.micro, t3.small, t3.medium."
  }
}