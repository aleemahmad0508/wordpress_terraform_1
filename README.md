# 🚀 Production-Ready 3-Tier WordPress Infrastructure on AWS using Terraform

## 📌 Project Overview

This project demonstrates how to build a **production-inspired 3-tier WordPress architecture on AWS** by following DevOps best practices. The infrastructure was first deployed manually to understand the interaction between AWS services and then automated using Terraform. High availability, security hardening, and CI/CD were added to create a scalable and maintainable cloud environment.

The project follows the principles of **Infrastructure as Code (IaC)** and deploys a highly available WordPress application using Amazon EC2, Amazon RDS, Amazon EFS, Auto Scaling Groups, an Application Load Balancer, and GitHub Actions.

---

# 🏗️ Architecture

```
                    Internet
                        │
                Application Load Balancer
                        │
        ┌───────────────┴───────────────┐
        │                               │
      EC2 Instance                  EC2 Instance
      (Private AZ-1)               (Private AZ-2)
        │                               │
        └───────────────┬───────────────┘
                        │
                 Amazon EFS (Shared Storage)
                        │
                  Amazon RDS MySQL
                  (Private Subnets)
```

---

# ☁️ AWS Services Used

* Amazon VPC
* Public & Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* Amazon EC2
* Launch Template
* Auto Scaling Group
* Application Load Balancer
* Target Group
* Amazon RDS (MySQL)
* Amazon EFS
* IAM Role
* AWS Systems Manager Session Manager
* Amazon S3 (Terraform Backend)
* Amazon DynamoDB (Terraform State Locking)
* GitHub Actions

---

# 🌐 Network Design

| Resource         | CIDR Block  |
| ---------------- | ----------- |
| VPC              | 10.0.0.0/16 |
| Public Subnet 1  | 10.0.1.0/24 |
| Public Subnet 2  | 10.0.2.0/24 |
| Private Subnet 1 | 10.0.3.0/24 |
| Private Subnet 2 | 10.0.4.0/24 |

### Network Components

* **Internet Gateway** provides internet access to public subnets.
* **Single NAT Gateway** in Public Subnet 1 enables outbound internet access for private resources.
* **Application Load Balancer** distributes incoming traffic across EC2 instances.
* **Amazon RDS** and **Amazon EFS** are deployed in private subnets for improved security.

---

# 📂 Project Structure

```text
.
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml
│       └── terraform-apply.yml
│
├── wordpress-terraform/
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── main.tf
│   ├── terraform.tfvars
│   ├── user-data.sh
│   │
│   └── modules/
│       ├── network/
│       ├── security/
│       ├── ec2/
│       ├── launch-template/
│       ├── alb/
│       ├── autoscaling/
│       ├── rds/
│       └── efs/
```

---

# ⚙️ Features

* Production-style 3-tier architecture
* Infrastructure as Code using Terraform
* Modular Terraform project
* Remote Terraform state using Amazon S3
* State locking with Amazon DynamoDB
* Application Load Balancer
* Launch Template
* Auto Scaling Group
* Amazon RDS MySQL
* Amazon EFS shared storage
* IAM Role for EC2
* AWS Systems Manager Session Manager
* Encrypted storage
* GitHub Actions CI/CD pipeline
* Manual approval before deployment

---

# 🚀 Deployment Workflow

## 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/<repository-name>.git
```

```bash
cd wordpress-terraform
```

---

## 2. Initialize Terraform

```bash
terraform init
```

---

## 3. Validate Configuration

```bash
terraform validate
```

---

## 4. Review Execution Plan

```bash
terraform plan
```

---

## 5. Deploy Infrastructure

```bash
terraform apply
```

---

## 6. Destroy Infrastructure

```bash
terraform destroy
```

---

# 🔄 CI/CD Pipeline

### Pull Request

* Terraform Format (`terraform fmt`)
* Terraform Validation (`terraform validate`)
* Terraform Plan (`terraform plan`)

### Merge to Main

* Manual Approval
* Terraform Apply (`terraform apply`)

This workflow helps ensure infrastructure changes are validated before deployment.

---

# 🔐 Security Highlights

* IAM Role attached to EC2 instances
* AWS Systems Manager Session Manager instead of SSH
* Least-privilege Security Groups
* Private Amazon RDS deployment
* Private Amazon EFS deployment
* Encrypted Amazon EBS volumes
* Encrypted Amazon RDS
* Encrypted Amazon EFS
* Encrypted Terraform backend in Amazon S3

---

# 📈 High Availability

* Multi-AZ deployment
* Auto Scaling Group
* Launch Template
* Application Load Balancer
* Health Checks
* Automatic instance replacement
* Shared storage using Amazon EFS
* Persistent database using Amazon RDS

---

# 🧪 Testing Performed

* Successfully deployed the complete infrastructure using Terraform.
* Verified WordPress accessibility through the Application Load Balancer.
* Confirmed data persistence after restarting an EC2 instance.
* Tested Auto Scaling by terminating an EC2 instance and verifying automatic replacement.
* Validated that uploaded media remained available through Amazon EFS.
* Confirmed GitHub Actions executed Terraform validation and deployment workflows successfully.

---

# 📚 Skills Demonstrated

* Amazon Web Services (AWS)
* Virtual Private Cloud (VPC)
* Amazon EC2
* Amazon RDS
* Amazon EFS
* Application Load Balancer
* Auto Scaling
* IAM
* AWS Systems Manager
* Terraform
* Infrastructure as Code (IaC)
* GitHub Actions
* CI/CD
* High Availability
* Cloud Networking
* DevOps

---

# 🎯 Future Improvements

* Deploy NAT Gateways in both Availability Zones for higher availability.
* Integrate Amazon CloudWatch for monitoring and alerting.
* Add automated backup and recovery strategies.
* Implement blue/green deployment for infrastructure updates.
* Introduce automated security scanning within the CI/CD pipeline.

---

# 👨‍💻 Author

**Aleem Ahmad**

If you found this project helpful, feel free to ⭐ the repository and connect with me on LinkedIn to follow my cloud and DevOps journey.
