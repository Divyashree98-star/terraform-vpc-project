# Terraform AWS Web Application Infrastructure

This project provisions a **highly available web application infrastructure on AWS** using **Terraform**. It creates a custom VPC, public subnets across multiple Availability Zones, EC2 instances running Apache, an Application Load Balancer (ALB)

---

## 🏗️ Architecture Overview

The infrastructure includes:

* Custom **VPC**
* **2 Public Subnets** in different AZs (`ap-south-1a`, `ap-south-1b`)
* **Internet Gateway** & Route Table
* **Security Group** allowing HTTP & SSH
* **2 EC2 instances** running a web server
* **Application Load Balancer (ALB)**
* **Target Group** with health checks

```
User
 │
 ▼
Application Load Balancer (HTTP:80)
 │
 ├── EC2 Instance (Subnet-1, AZ-1)
 └── EC2 Instance (Subnet-2, AZ-2)
```

---

## 📁 Project Structure

```
.
├── main.tf              # Main Terraform resources
├── variables.tf         # Input variables
├── terraform.tfvars     # Variable values
├── userdata.sh          # User data for web1
├── userdata1.sh         # User data for web2
├── provider.tf          # AWS provider configuration
├── outputs.tf           # Output values
└── README.md            # Project documentation
```

---

## ⚙️ Resources Created

### Networking

* `aws_vpc`
* `aws_subnet` (2 public subnets)
* `aws_internet_gateway`
* `aws_route_table`
* `aws_route_table_association`

### Security

* `aws_security_group`
* Ingress rules:

  * HTTP (80) from `0.0.0.0/0`
  * SSH (22) from `0.0.0.0/0`
* Egress rule:

  * All outbound traffic allowed

### Compute

* 2 × `aws_instance` (t3.micro)
* Apache installed using `user_data`

### Load Balancing

* `aws_lb` (Application Load Balancer)
* `aws_lb_target_group`
* `aws_lb_listener`
* Target group attachments

### Storage

* `aws_s3_bucket`

---

## 🔧 Prerequisites

* AWS Account
* Terraform ≥ 1.5
* AWS CLI configured

```bash
aws configure
```

---

## 🧾 Variables

| Variable Name | Description        | Example       |
| ------------- | ------------------ | ------------- |
| `vpc_cidr`    | CIDR block for VPC | `10.0.0.0/16` |
| `sub1_cidr`   | CIDR for subnet 1  | `10.0.1.0/24` |
| `sub2_cidr`   | CIDR for subnet 2  | `10.0.2.0/24` |

---

## 🚀 How to Deploy

### 1️⃣ Initialize Terraform

```bash
terraform init
```

### 2️⃣ Validate Configuration

```bash
terraform validate
```

### 3️⃣ Plan Infrastructure

```bash
terraform plan
```

### 4️⃣ Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted.

---

## 🌐 Access the Application

After deployment:

* Copy the **ALB DNS name** from Terraform output or AWS Console
* Open in browser:

```
http://<ALB-DNS-NAME>
```

Traffic will be load-balanced between both EC2 instances.

---

## 🧹 Destroy Infrastructure

To clean up all resources:

```bash
terraform destroy
```

---

## 🔒 Security Notes

* SSH is open to the world (`0.0.0.0/0`) → restrict in production
* S3 bucket name must be **globally unique**
* Use IAM roles instead of access keys where possible

---

## 📌 Improvements (Future Scope)

* HTTPS using ACM certificate
* Auto Scaling Group (ASG)
* Private subnets with NAT Gateway
* Remote backend (S3 + DynamoDB)
* Modular Terraform structure

---

## 👩‍💻 Author

**Divyashree L B**
DevOps / Cloud Enthusiast
Terraform • AWS • Linux

---

## ⭐ If you find this useful

Give the repository a ⭐ and feel free to contribute!
