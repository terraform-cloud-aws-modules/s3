# terraform s3 module

#### Requirements

 - aws cli (with working credentials)

## Goal

Creating a S3 Bucket with a list of "main/root" folders and also subfolders from a list for each "main/root" folder.
Following this example you'll get the following folder structure for your S3 Bucket:

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

## Create your terraform base Structure

I would advise you to start with this:

    .
    ├── config
    │   └── aws-dev.tfvars
    ├── main.tf
    ├── outputs.tf
    └── variables.tf

    1 directory, 4 files

### tfvars

"config" is home for different *.tfvars files in different environments.
In this example we're starting with one *.tfvars file.

#### aws-dev.tfvars

Please put the following code in your aws-dev.tfvars:

    profile		= "default"
    region		= "eu-central-1"

    tags = {
      environment     = "testing"
      team            = "terraformers"
      project         = "aws"
    }

##### Optional

Install terragrunt
Mac:

    brew install terragrunt

and split your config into something like:

    .
    └── config
        └── aws-dev
            ├── common.tfvars
            └── region.tfvars

In your root folder (where your main.tf is located) create "terragrunt.hcl" with this content:

    terraform {
      extra_arguments "common_vars" {
        commands = ["plan", "apply"]

        arguments = [
          "-var-file=config/aws-dev/region.tfvars",
          "-var-file=config/aws-dev/common.tfvars"
        ]
      }
    }

### main.tf

Create the main.tf with the following code:

    provider "aws" {
      profile = var.profile
      region  = var.region
      version = "3.12.0"
    }

    module "s3" {
      source      = "git@github.com:terraform-cloud-aws-modules/s3.git"
      bucketname  = "INSERT-YOUR-BUCKET-NAME-HERE"
      rootlevelfolder = ["foo", "bar", "baz"]
      sublevelfolder  = ["one", "two", "three", "four", "five", "six"]
      tags = var.tags
    }

### variables.tf

You have to declare variables from tfvars file like:

    variable "profile" {
      type        = string
      description = "provider profile"
    }

    variable "region" {
      type        = string
      description = "provider region"
    }

    variable "tags" {
        type        = map
        description = "Tags used for AWS resources"
    }

### outputs.tf

You can use the outputs from the module in this file like:

    output "bucket_id" {
        value = module.s3.this_s3_bucket_id
    }

    output "bucket_arn" {
        value = module.s3.this_s3_bucket_arn
    }

    output "bucket_region" {
        value = module.s3.this_s3_bucket_region
    }

## terraform init & run

You can now run

    terraform init

and then run plan or apply with tfvars file like:

    terraform plan -var-file=config/aws-dev.tfvars

or if you had installed terragrunt, just run:

    terragrunt init
    terragrunt plan
