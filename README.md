# terraform_aws_autoscaling_public_private_subnet

This project sets up an AWS infrastructure using Terraform, including a VPC with public and private subnets, an Auto Scaling group, and an Application Load Balancer (ALB). The Auto Scaling group launches instances with Nginx installed, and the instances are registered with the ALB.

## Components

### 1. Terraform Configuration

The main Terraform configuration file (`main.tf`) defines the overall structure of the project, including the provider configuration, backend configuration, and module calls.

### 2. Provider Configuration

The `provider "aws"` block specifies the AWS region where the resources will be created.

### 3. Backend Configuration

The `backend "s3"` block configures the remote state storage for Terraform using an S3 bucket and a DynamoDB table for state locking.

### 4. VPC Module

The `vpc` module sets up the Virtual Private Cloud (VPC) with public and private subnets. It includes the following configurations:
- `vpc_cidr`: The CIDR block for the VPC.
- `availability_zones`: The availability zones for the subnets.
- `public_subnet_cidrs`: The CIDR blocks for the public subnets.
- `private_subnet_cidrs`: The CIDR blocks for the private subnets.
- `web_asg_22_cidr_blocks`: CIDR blocks to allow SSH access.
- `web_asg_80_cidr_blocks`: CIDR blocks to allow HTTP access.
- `web_sg_cidr_blocks`: CIDR blocks to allow HTTP access.

### 5. Subnets

The `aws_subnet` resources create public and private subnets within the VPC:
- Public subnets are associated with an Internet Gateway to allow outbound internet access.
- Private subnets are associated with a NAT Gateway to allow outbound internet access while keeping the instances private.

### 6. Internet Gateway

The `aws_internet_gateway` resource creates an Internet Gateway and attaches it to the VPC, allowing public subnets to access the internet.

### 7. NAT Gateway

The `aws_nat_gateway` resource creates a NAT Gateway in each public subnet, allowing instances in private subnets to access the internet.

### 8. Route Tables

The `aws_route_table` and `aws_default_route_table` resources create route tables for the public and private subnets:
- Public route table routes traffic to the Internet Gateway.
- Private route tables route traffic to the NAT Gateway.

### 9. Security Groups

The `aws_security_group` resource creates security groups to control inbound and outbound traffic for the instances:
- Allows HTTP (port 80) and SSH (port 22) access.

### 10. Auto Scaling Module

The `autoscaling` module sets up the Auto Scaling group and related resources. It includes the following configurations:
- `instance_type`: The instance type for the EC2 instances.
- `key_name`: The key pair name for SSH access.
- `ami_id`: The AMI ID for the EC2 instances.
- `web_asg_min_size`: The minimum size of the Auto Scaling group.
- `web_asg_max_size`: The maximum size of the Auto Scaling group.

### 11. Launch Template

The launch template defines the configuration for the EC2 instances, including the AMI ID, instance type, key pair, user data script, and security groups.

### 12. Auto Scaling Group

The Auto Scaling group manages the EC2 instances, ensuring that the desired number of instances are running and registered with the target group.

### 13. Scaling Policies

The scaling policies define the conditions for scaling the Auto Scaling group up or down based on CloudWatch alarms.

### 14. Application Load Balancer (ALB)

The ALB distributes incoming traffic across the EC2 instances in the Auto Scaling group. It includes the following configurations:
- `security_groups`: The security groups for the ALB.
- `subnets`: The subnets for the ALB.
- `vpc_id`: The VPC ID for the ALB.

### 15. Target Group

The target group registers the EC2 instances and routes traffic to them based on the health checks.

### 16. Listener

The listener defines the port and protocol for the ALB to listen for incoming traffic and forward it to the target group.

## Usage

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/terraform_aws_autoscaling_public_private_subnet.git
   cd terraform_aws_autoscaling_public_private_subnet

2. **Initialize Terraform:**

   ```sh
   terraform init
3. **Review the Terraform plan:**

   ```sh
   terraform plan
4. **Apply the Terraform configuration:**

   ```sh
   terraform apply
5. **Outputs:**

   ```sh
   After the apply completes, Terraform will output the DNS name of the ALB and other useful information.
# terraform_aws_autoscaling_public_private_subnet

## Variables

The following variables can be configured in `variables.tf`:

- `region`: AWS region (default: `us-east-1`)
- `vpc_cidr`: CIDR block for the VPC (default: `10.0.0.0/20`)
- `availability_zones`: List of availability zones (default: `["us-east-1a", "us-east-1b"]`)
- `private_subnet_cidrs`: CIDR blocks for the private subnets (default: `["10.0.0.0/24", "10.0.4.0/24"]`)
- `public_subnet_cidrs`: CIDR blocks for the public subnets (default: `["10.0.8.0/24", "10.0.12.0/24"]`)
- `web_sg_cidr_blocks`: CIDR blocks to allow HTTP access (default: `["0.0.0.0/0"]`)
- `web_asg_22_cidr_blocks`: CIDR blocks to allow SSH access (default: `["0.0.0.0/0"]`)
- `web_asg_80_cidr_blocks`: CIDR blocks to allow HTTP access (default: `["0.0.0.0/0"]`)
- `ami_id`: The AMI ID to use for the instances (default: `ami-04b4f1a9cf54c11d0`)
- `key_name`: The key name to use for the instances (default: `tryout`)
- `instance_type`: The instance type to use for the instances (default: `t2.micro`)

## Outputs

The following outputs are provided:

- `vpc_id`: The ID of the VPC
- `public_subnet_ids`: The IDs of the public subnets
- `private_subnet_ids`: The IDs of the private subnets
- `web_private_asg_id`: The ID of the security group for the web instances
- `instances`: The IDs of the instances
- `web_asg_id`: The ID of the web ASG
- `web_url`: The URL of the web instances
