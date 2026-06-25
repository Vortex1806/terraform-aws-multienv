locals {
    env = {
        dev = {
            env = "dev"
            instance_count = 2
            bucket_count = 1
            dynamodb_table_count = 1
        }
        stg = {
            env = "stg"
            instance_count = 3
            bucket_count = 1
            dynamodb_table_count = 1
        }
        prd = {
            env = "prd"
            instance_count = 4
            bucket_count = 2
            dynamodb_table_count = 2
        }
    }
    current = lookup(local.env, terraform.workspace, local.env["dev"])
}

module "ec2" {
    source = "./modules/ec2"
    env = terraform.workspace
    ec2_instance_count = local.current.instance_count
}

module "dynamodb" {
    source = "./modules/dynamo_db"
    env = terraform.workspace
    dynamodb_table_count = local.current.dynamodb_table_count
}

module "s3" {
    source = "./modules/s3"
    env = terraform.workspace
    s3_bucket_count = local.current.bucket_count
}