# terraform s3 module

#### Requirements

 - aws cli (with working credentials)

## Goal

Creating a S3 Bucket with a list of "main/root" folders and also a list of subfolders for each "main/root" folder.
With this example this module will provide you with the following structure for your S3 Bucket:

    |_ foo
    	|_ one
    	|_ two
    	|_ three
    	|_ four
    	|_ five
    	|_ six
    |_ bar
    	|_ one
    	|_ two
    	|_ three
    	|_ four
    	|_ five
    	|_ six
    |_ baz
    	|_ one
    	|_ two
    	|_ three
    	|_ four
    	|_ five
    	|_ six

## Install terraform

On Mac:

    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform

## Create Terraform base

I would advise you to do it like this:

    .
    ├── config
    │   └── aws-dev.tfvars
    ├── main.tf
    └── variables.tf
    
    1 directory, 3 files

### tfvars

You can put in "config" different variables for different environments in a *.tfvars file.

#### aws-dev.tfvars

In this example the tfvars file contains only:

    profile		= "default"
    region		= "eu-central-1"

for our main.tf

### main.tf

The main.tf contains the following code:

    provider "aws" {
      profile = var.profile
      region  = var.region
      version = "3.12.0"
    }

    module "s3" {
      source      = "git@github.com:terraform-cloud-aws-modules/s3.git"
      bucketname  = "INSERT-YOUR-BUCKET-NAME-HERE"
    }

### variables.tf

You have to declare variables from tfvars file like:

    variable "profile" {
      type          = string
      description   = "provider profile"
    }
    
    variable "region" {
      type          = string
      description   = "provider region"
    }

## terraform init & run

You can now run

    terraform init

and then run plan or apply with tfvars file like:

    terraform plan -var-file=config/aws-dev.tfvars

