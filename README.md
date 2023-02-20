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
- An EC2 security group for your EC2 instances that will host web applications. Add ingress rule to allow TCP traffic on ports 22, 80, 443, and port on which your application runs from anywhere in the world.

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
   
