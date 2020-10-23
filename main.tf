# combine variable lists into 'folderstructure'
locals {
  folderstructure = "${combine(var.rootlevelfolder, var.sublevelfolder)}"
}

# create s3 bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucketname
  acl = var.acl
  versioning {
    enabled = var.versioning
  }
	//tags will be here
}

# generate root and subfolders
resource "aws_s3_bucket_object" "this" {
    bucket  = aws_s3_bucket.this.id
    acl     = var.acl
    key     =  ${element(local.folderstructure, count.index)[0]}/${element(local.folderstructure, count.index)[1]}
    content_type = "application/x-directory"
}