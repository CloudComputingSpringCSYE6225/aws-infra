# Terraform AWS Infrastructure - CSYE 6225

## <ins>By Rebecca Biju : 002768633</ins>
---

### About
Use Terraform for Infrastructure as Code. Set up a Virtual Private Cloud (VPC) in AWS with the following networking resources:

- 3 public subnets and 3 private subnets, each in a different availability zone in the same region in the same VPC
- An Internet Gateway resource attached to the VPC
- A public route table with all public subnets attached to it
- A private route table with all private subnets attached to it
- A public route in the public route table with the destination CIDR block 0.0.0.0/0 and the internet gateway created above as the target.
- An EC2 instance which will be launched in the VPC created by the Terraform template. The EC2 instance will not be launched in the default VPC.
- An EC2 security group (Application) for your EC2 instances that will host web applications. Add ingress rule to allow TCP traffic on ports 22, 80, 443, and port on which your application runs from anywhere in the world. Add Egress rule to access anywhere in the world
- An EC2 security group (Database) for your RDS instances. Add ingress rule to allow TCP traffic on the port 3306 for MySQL/MariaDB or 5432 for PostgreSQL.
- An S3 bucket with a randomly generated name. A lifecycle policy for the bucket to transition objects from STANDARD storage class to STANDARD_IA storage class after 30 days
- An RDS parameter group to match your database (Postgres or MySQL) and its version. Then RDS DB instance uses the new parameter group and not the default parameter group.
- EC2 instance should be launched with user data which includes Database username, password, hostname, and S3 bucket name
- An IAM Policy WebAppS3 that will allow EC2 instances to perform S3 buckets. This is required for applications on your EC2 instance to talk to the S3 bucket.
- An IAM role EC2-CSYE6225 for the EC2 service and the WebAppS3 policy is attached to it. This role is attached to your EC2 instance
- The Terraform template adds/updates 'A' record to the Route53 zone so that the domain points to the EC2 instance and the web application is accessible through http://your-domain-name.tld/. Later, an Alias is given so that the domain points to the load balancer
- An IAM Role for CloudWatch agent is attached to the EC2 instance. The policy attached is `CloudWatchAgentServerPolicy`
- A Security group for Load Balancer is created and the application will now be accessed from Load Balancer IP only
- `Autoscaling group` : Instead of launching standalone EC2 instances, we are now going to launch them in an auto-scaling group with a minimum of 1 instance and a maximum of 3.
- When auto scaling is introduced, we create EC2 instances indirectly using a launch template and the resource of `aws_instance` is deleted
- Command to import SSL Certificate into AWS Certificate Manager 
   ```shell
      aws acm import-certificate --profile <profile_name> --region us-east-1 --certificate fileb://<cretificate_file_in_crt> --private-key fileb://<private_key_in_pem> --certificate-chain fileb://<ca-bundle_file>
    ```
- `AWS Lambda`: We have created a lambda function that is triggered on SNS topic. We have subscribed to SNS topic `image-updates-topic`
- The data is stored in a dynamo DB from Lambda function
Note: The values are not hardcoded in the Terraform files


### Prerequisites

- `Terraform` [[link](https://developer.hashicorp.com/terraform/downloads?ajs_aid=fabfcbfb-08e9-498d-ac4b-fb1011298861&product_intent=terraform)]
- `AWS CLI` [[link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)]
- An AWS IAM account with access keys set up to create VPCs

### How to run?

1. Clone the repository from Organization
    ```shell
      git clone git@github.com:CloudComputingSpringCSYE6225/aws-infra.git
    ```
2. In the command line, navigate to the directory where the vpc.tf file is located

3. Place demo.tfvars file in this directory

4. Initialize the Terraform configuration file
    ```shell
      terraform init
    ```
5. Preview of the resources that will be created.
    ```shell
      terraform plan -var-file=demo.tfvars
    ```
6. Format the files
    ```shell
      terraform fmt
    ```
7. Create the resources.
    ```shell
      terraform apply -var-file=demo.tfvars
    ```
8. If you want to delete the resources, run the following command
    ```shell
      terraform destroy -var-file=demo.tfvars
    ```
