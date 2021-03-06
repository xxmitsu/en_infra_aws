#
# Project Name:: en_infra_aws
# File:: variables.tf
#
# Copyright (C) 2017 - Present
# Author: 'Mihai Vultur <mihai.vultur@___.com>'
#
# All rights reserved
#
# Description:
#   Variables we're using with their description.
#   If a default value is set, the variable is optional.
#   Otherwise, the variable is required.

#-- Naming
variable "aws_region" {
  description = "AWS region"
  type = "string"
  default = "us-east-1" 
}
variable "aws_azs" {
  description = "AWS Availability zones list in which to distribute subnets"
  type = "list"
}
variable "vpc_name" {
  description = "Name of the VPC"
  type = "string"
}

#-- Networking
variable "vpc_cidr" {
  description = "The CIDR block for our VPC"
  type = "string"
}
variable "vpc_private_subnets" {
  description = "The CIDR blocks for our private subnets"
  type = "list"
 }
variable "vpc_public_subnets"  {
  description = "The CIDR blocks for our public subnets"
  type = "list"
}
variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default = true
}
variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default = true
}

#-- Security
variable "ssh_user" {
  description = "Name of the ssh user used for connecting to the remote instances"
  type = "string"
}

variable "ssh_public_key_name" {
  description = "Name of the SSH Key"
  type = "string"
}
variable "ssh_public_key_file" {
  description = "Location for the public ssh key file"
  type = "string"
}

#-- EC2
variable "ec2_custom_image" {
  description = "Name of the AWS AMI to be used when spawning EC2 instance. Takes precedence over 'ec2_os'"
  type = "string"
}

variable "ec2_os" {
  description = "OS version that will be used to find AMI image for EC2 creation"
  type = "string"
}

#--
variable "nat_inbound_ports" {
  description = "Allow following TCP ports to NAT instance."
  default  = "22,443"
}
#--
variable "vpn_port" {
  description = "TCP port OpenVPN will listen to"
  default  = "1194"
}

##-- Tags for accounting
variable "default_tags" {
  description = "A map of tags to add to all resources"
  type        = "map"
  default = {
    "Author" = "mike"
    "Provisioner" = "terraform"
  }
}

#-- Determine latest CentOS AMI by our search criteria
data "aws_ami" "centos" {
  most_recent   = true
  owners = ["679593333241"] # CentOS
  filter {
    name   = "owner-alias"
    values = ["aws-marketplace"]
  }
  filter {
    name    = "name"
    values  = ["${var.ec2_os}*"]
  }
  filter {
    name    = "state"
    values  = ["available"]
  }
  filter {
    name    = "architecture"
    values  = ["x86_64"]
  }
  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
}

# TODO for future
#...

