# Terraform Serverless File Metadata Extractor

## Overview

This project provisions a fully serverless file management and metadata extraction platform on AWS using Terraform.

The infrastructure automates the deployment of AWS resources required for file upload, metadata processing, storage, retrieval, download, and deletion.

The solution follows Infrastructure as Code (IaC) principles, allowing the entire architecture to be deployed, managed, and version-controlled through Terraform.

---

## Architecture

### Workflow

1. Users upload files through the frontend application.
2. Files are stored in Amazon S3.
3. S3 triggers a Lambda function when a new object is created.
4. Lambda extracts metadata from the uploaded file.
5. Metadata is stored in DynamoDB.
6. API Gateway exposes REST endpoints for:

   * Uploading files
   * Listing files
   * Downloading files
   * Deleting files
7. CloudFront delivers the frontend globally with low latency.

---

## AWS Services Used

| Service            | Purpose                                 |
| ------------------ | --------------------------------------- |
| Amazon S3          | File storage and static website hosting |
| AWS Lambda         | Serverless backend processing           |
| Amazon DynamoDB    | Metadata storage                        |
| Amazon API Gateway | REST API endpoints                      |
| Amazon CloudFront  | Content delivery network                |
| AWS IAM            | Security and access management          |

---

## Infrastructure Components

### Storage Layer

* S3 File Storage Bucket
* S3 Static Website Bucket

### Compute Layer

* UploadFileLambda
* MetadataProcessor
* ListFiles
* DownloadFileLambda
* DeleteFileLambda

### Database Layer

* DynamoDB Table for storing file metadata

### Networking Layer

* API Gateway REST API
* CloudFront Distribution

### Security Layer

* IAM Roles
* IAM Policies
* Lambda Execution Permissions

---

## Project Structure

```text
terraform-serverless-file-metadata/
│
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── script.js
│
├── lambda/
│   ├── UploadFileLambda.py
│   ├── MetadataProcessor.py
│   ├── ListFiles.py
│   ├── DownloadFileLambda.py
│   └── DeleteFileLambda.py
│
├── provider.tf
├── variables.tf
├── outputs.tf
├── s3.tf
├── dynamodb.tf
├── iam.tf
├── archive.tf
├── lambda.tf
├── apigateway.tf
├── website.tf
├── frontend.tf
├── cloudfront.tf
│
├── README.md
├── LICENSE
└── .gitignore
```

---

## Prerequisites

Before deploying, ensure you have:

* AWS Account
* AWS CLI configured
* Terraform installed (v1.5+)
* IAM permissions for:

  * S3
  * Lambda
  * API Gateway
  * DynamoDB
  * CloudFront
  * IAM

---

## Deployment Steps

### Clone Repository

```bash
git clone https://github.com/<your-username>/Terraform-Serverless-File-Metadata.git

cd Terraform-Serverless-File-Metadata
```

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Infrastructure Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

---

## Outputs

After successful deployment Terraform returns:

* API Gateway URL
* DynamoDB Table Name
* File Storage Bucket Name
* CloudFront Distribution URL

---

## Destroy Infrastructure

To remove all deployed resources:

```bash
terraform destroy
```

---

## Security Features

* Least Privilege IAM Policies
* Serverless Architecture
* S3 Event-Based Processing
* HTTPS Delivery through CloudFront
* Managed AWS Services

---

## Infrastructure as Code Benefits

* Automated Deployment
* Repeatable Environment Creation
* Version Controlled Infrastructure
* Reduced Manual Configuration
* Faster Disaster Recovery

---

## License

This project is licensed under the MIT License.
